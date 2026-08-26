<#
  DPTC one-command deploy (Windows PowerShell).

  dpowelltc.com is served from the Ohio box's /var/www/html, not GitHub Pages.
  This pushes your local commits to GitHub main, tells the box to pull + publish,
  then verifies the live site.

  Usage:
    .\scripts\deploy.ps1            # push, then deploy
    .\scripts\deploy.ps1 -NoPush    # deploy whatever is already on main
#>
[CmdletBinding()]
param([switch]$NoPush)
$ErrorActionPreference = 'Stop'

$Instance = 'i-088a1050030cac14d'
$Region   = 'us-east-2'
$RepoRoot = Split-Path $PSScriptRoot -Parent

if (-not $NoPush) {
  Write-Host '-> pushing local commits to origin/main' -ForegroundColor Cyan
  git -C $RepoRoot push origin HEAD:main
}

Write-Host '-> triggering box deploy (SSM)' -ForegroundColor Cyan
$cmdId = (aws ssm send-command `
  --instance-ids $Instance --region $Region `
  --document-name AWS-RunShellScript `
  --parameters commands=/opt/deploy-dpowelltc.sh `
  --query 'Command.CommandId' --output text).Trim()

do {
  Start-Sleep -Seconds 3
  $inv = aws ssm get-command-invocation --command-id $cmdId --instance-id $Instance --region $Region --output json | ConvertFrom-Json
} while ($inv.Status -in 'Pending', 'InProgress')

if ($inv.StandardOutputContent) { Write-Host $inv.StandardOutputContent.Trim() -ForegroundColor Green }
if ($inv.Status -ne 'Success') {
  Write-Host "DEPLOY FAILED: $($inv.Status)" -ForegroundColor Red
  if ($inv.StandardErrorContent) { Write-Host $inv.StandardErrorContent }
  exit 1
}

Write-Host '-> verifying live site' -ForegroundColor Cyan
try {
  $r = Invoke-WebRequest 'https://dpowelltc.com/missed-call-audit' -UseBasicParsing -TimeoutSec 15
  Write-Host "   https://dpowelltc.com/missed-call-audit  HTTP $($r.StatusCode)" -ForegroundColor Green
} catch {
  Write-Host "   (live check skipped: $($_.Exception.Message))" -ForegroundColor Yellow
}
Write-Host 'Done.' -ForegroundColor Green

param (
    [string]$Action="default",
	[hashtable]$properties=@{},
    [switch]$Help
)

$Here = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Import-Module "$Here\Common"

Install-Chocolatey

Install-Psake

Install-Git

Install-DocFx

$psakeDirectory = (Resolve-Path $env:ChocolateyInstall\lib\Psake*)

Import-Module (Join-Path $psakeDirectory "tools\Psake\Psake.psm1")

if($Help)
{ 
	try 
	{
		Write-Host "Available build tasks:"
		psake -nologo -docs | Out-Host -paging
	} 
	catch {}

	return
}

Invoke-Psake -buildFile "$Here\Default.ps1" -parameters $properties -tasklist $Action
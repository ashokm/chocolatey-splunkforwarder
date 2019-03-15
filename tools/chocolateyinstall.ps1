$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=windows&version=7.2.3&product=universalforwarder&filename=splunkforwarder-7.2.3-06d57c595b80-x86-release.msi&wget=true' # download url, HTTPS preferred
$url64 = 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=7.2.3&product=universalforwarder&filename=splunkforwarder-7.2.3-06d57c595b80-x64-release.msi&wget=true' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url

$packageArgs = @{
    packageName    = $packageName
    unzipLocation  = $toolsDir
    fileType       = 'msi'
    url            = $url
    url64bit       = $url64

    softwareName   = 'SplunkUniversalForwarder'
    checksum       = '00468A7C83C028971BF965B454F49D7F'
    checksumType   = 'md5'
    checksum64     = 'EAADA91BCA364B0B3D37163BEB9F4100'
    checksumType64 = $checksumType

    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" AGREETOLICENSE=YES" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

param(
    [Parameter(Mandatory = $true)]
    [string] $adminUsername,

    [Parameter(Mandatory = $true)]
    [string] $adminPassword
)

# Define SQL Server parameters
$SQLServerEdition = "Developer"  # You can change this to match the desired edition (e.g., "Standard", "Enterprise", etc.)
$SQLServerVersion = "15.0"       # You can change this to match the desired SQL Server version (e.g., "15.0" for SQL Server 2019)
$SQLInstanceName = "MSSQLSERVER" # Change this to specify a custom instance name if needed, or keep it as "MSSQLSERVER" for the default instance

# Check if SQL Server is already installed
$SQLInstalled = Get-WindowsFeature | Where-Object { $_.Name -eq "MSSQLSERVER" }

if ($SQLInstalled) {
    Write-Host "SQL Server is already installed."
} else {
    # Install SQL Server
    $Arguments = "/IACCEPTSQLSERVERLICENSETERMS /ACTION=Install /FEATURES=SQL /INSTANCENAME=$SQLInstanceName /SQLSVCACCOUNT='NT AUTHORITY\SYSTEM' /AGTSVCACCOUNT='NT AUTHORITY\SYSTEM' /SQLSYSADMINACCOUNTS='BUILTIN\Administrators' /SECURITYMODE=SQL /SAPWD='$adminPassword' /SQLCOLLATION='SQL_Latin1_General_CP1_CI_AS' /Q /SKIPRULES=RebootRequiredCheck"

    $SQLInstallCmd = "C:\path\to\SQL\Setup\Setup.exe"  # Replace this with the path to your SQL Server setup executable

    Write-Host "Installing SQL Server..."
    Start-Process -FilePath $SQLInstallCmd -ArgumentList $Arguments -Wait

    if ($LASTEXITCODE -eq 0) {
        Write-Host "SQL Server installation completed successfully."
    } else {
        Write-Host "SQL Server installation failed with exit code: $LASTEXITCODE"
    }
}

# Login to VSphere
#Connect-VIServer -Server mainframe.vault.kps-lv.com

# Type the VM Name
$Name = Read-Host 'Type VM Name'

# Select the Template
$VMTemplate = "Ubunutu2004_011222"

# Select the Host
$VMHosts = Get-Content C:\Users\twotronz\Documents\VMHosts.csv
$VMHost = $VMHosts | Out-GridView -Title "VM Hosts" -PassThru

# Select the Datastore
$Datastores = Get-Content C:\Users\twotronz\Documents\Datastores.csv
$Datastore = $Datastores | Out-GridView -Title "Datastores" -PassThru

# Select the Network Name
$NetworkNames = Get-Content C:\Users\twotronz\Documents\VNics.csv
$NetworkName = $NetworkNames | Out-GridView -Title "VNICS" -PassThru

# Select Network Adapter Type
$NetworkAdapterType = "VMXNET 3"

# Select the OS Spec
$OSSpec = "MYBOFI-Ubuntu2004"

# Type Annotations
$Application = Read-Host 'Type Application Name'
$ApplicationOwner = Read-Host 'Type Application Owner Name'
$ApplicationRole = Read-Host 'Type Application Role Name'
$ApplicationSupport = Read-Host 'Type Application Support Name'
$BuiltBy = Read-Host 'Type Built By Name'
$BuiltDate = Read-Host 'Type Built Date'
$BusinessUnit = Read-Host 'Type Business Unit'
$Department = Read-Host 'Type Department Name'
$Environment = Read-Host 'Type Environment Name'
$SupportOwner = Read-Host 'Type Support Owner Name'
$SupportOwnerDL = Read-Host 'Type Support Owner DL Name'
$SystemsSupport = Read-Host 'Type Systems Support Name'


# Create VM Script
New-VM -Name $Name -Template $VMTemplate –VMHost $VMHost -Datastore $Datastore -NetworkName $NetworkName -OSCustomizationSpec $OSSpec

# Set Network Adapter
Set-NetAdapter -Type $NetworkAdapterType -Connected:$true

# Set VM Annotations
Set-Annotation -Entity $Name -CustomAttribute "Application" -Value $Application
Set-Annotation -Entity $Name -CustomAttribute "Application Owner" -Value $ApplicationOwner
Set-Annotation -Entity $Name -CustomAttribute "Application Role" -Value $ApplicationRole
Set-Annotation -Entity $Name -CustomAttribute "Application Support" -Value $ApplicationSupport
Set-Annotation -Entity $Name -CustomAttribute "Built By" -Value $BuiltBy
Set-Annotation -Entity $Name -CustomAttribute "Built Date" -Value $BuiltDate
Set-Annotation -Entity $Name -CustomAttribute "BusinessUnit" -Value $BusinessUnit
Set-Annotation -Entity $Name -CustomAttribute "Department" -Value $Department
Set-Annotation -Entity $Name -CustomAttribute "Environment" -Value $Environment
Set-Annotation -Entity $Name -CustomAttribute "Support Owner" -Value $SupportOwner
Set-Annotation -Entity $Name -CustomAttribute "Support Owner DL" -Value $SupportOwnerDL
Set-Annotation -Entity $Name -CustomAttribute "Systems Support" -Value $SystemsSupport
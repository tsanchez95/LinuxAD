# Login to VSphere
#Connect-VIServer -Server mainframe.vault.kps-lv.com

# Type the VM Name
$Name = Read-Host 'Type VM Name'

# Template
#$VMTemplate = " "

# Hosted Services
$ResourcePool = "Hosted Services"

# Datastore
$Datastore = "1 - HOST 1 - LOCAL"

# Network Name
$NetworkName = "90 - Hosting"

# Network Adapter Type
$NetworkAdapterType = "VMXNET 3"

# Create VM Script
New-VM -Name $Name -ResourcePool $ResourcePool -Datastore $Datastore -NetworkName $NetworkName

# Set Network Adapter
Set-NetAdapter -Type $NetworkAdapterType -Connected:$true
# Login to VSphere
#Connect-VIServer -Server mainframe.vault.kps-lv.com

# Type the VM Name
$Name = Read-Host 'Type VM Name'

# Template
#$VMTemplate = " "

$ResourcePool = "Hosted Services"

# Network Adapter Type
$NetworkAdapterType = "Vmxnet3"

# Create VM Script
New-VM -Name $Name -ResourcePool $ResourcePool

# Set Network Adapter
Set-NetworkAdapter -Type $NetworkAdapterType -Connected:$true
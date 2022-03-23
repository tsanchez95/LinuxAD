# Login to VSphere
#Connect-VIServer -Server mainframe.vault.kps-lv.com

# Type the VM Name
$Name = Read-Host 'Type VM Name'

# Template
$VMTemplate = "KPSLINUXTemplate"

# Resource Pool
$ResourcePool = "Hosted Services"

# Create VM Script
New-VM -Name $Name -ResourcePool $ResourcePool -Template $VMTemplate

# Set Network Adapter
Get-VM $Name | Get-NetworkAdapter | Set-NetworkAdapter -Type Vmxnet3 -Confirm:$false
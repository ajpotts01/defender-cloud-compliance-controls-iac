# https://learn.microsoft.com/en-au/training/modules/just-in-time-access/3-enable-just-in-time-virtual-machine-access
$ResourceGroup = "rg-defender-compliance-dev"
$Location = "eastus"

$JitPolicy = @(
    @{ 
        id="/subscriptions/$env:ARM_SUBSCRIPTION_ID/resourceGroups/$ResourceGroup/providers/Microsoft.Compute/virtualMachines/vm-1";
        ports=(
            @{ number=22; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"}, 
            @{ number=3389; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"}
        )
    },
    @{ 
        id="/subscriptions/$env:ARM_SUBSCRIPTION_ID/resourceGroups/$ResourceGroup/providers/Microsoft.Compute/virtualMachines/vm-2";
        ports=(
            @{ number=22; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"}, 
            @{ number=3389; protocol="*"; allowedSourceAddressPrefix=@("*"); maxRequestAccessDuration="PT3H"}
        )
    }    
)

Set-AzJitNetworkAccessPolicy `
    -Kind "Basic" `
    -Location $Location `
    -Name "default" `
    -ResourceGroupName $ResourceGroup `
    -VirtualMachine $JitPolicy



# https://learn.microsoft.com/en-au/training/modules/just-in-time-access/3-enable-just-in-time-virtual-machine-access
$ResourceGroup = "SET_RESOURCE_GROUP" # Based on TF var.app_name and workspace environment
$Location = "SET_REGION" # Based on var.region

# ARM subscription ID also needs to be set, same as using TF with azurerm provider

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

Start-AzJitNetworkAccessPolicy `
    -ResourceId "/subscriptions/$env:ARM_SUBSCRIPTION_ID/resourceGroups/$ResourceGroup/providers/Microsoft.Security/locations/$Location/jitNetworkAccessPolicies/default" `
    -VirtualMachine $JitPolicy `
    -Name "vm-1"
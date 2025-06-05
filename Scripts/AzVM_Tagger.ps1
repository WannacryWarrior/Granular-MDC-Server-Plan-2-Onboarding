<#
.SYNOPSIS
    Tags all Azure Virtual Machines, Hybrid Compute Machines, and Virtual Machine Scale Sets in a specified subscription.

.DESCRIPTION
    This script authenticates the user, prompts for a subscription ID, retrieves all compute-related resources 
    (including VMs, Hybrid Compute Machines, and VM Scale Sets), and applies a user-specified tag to each resource.
#>

# Step 1: Prompt for credentials and authenticate
Connect-AzAccount

# Step 2: Ask the user to supply the Subscription ID
$subscriptionId = Read-Host "Enter the Azure Subscription ID"
Set-AzContext -SubscriptionId $subscriptionId

# Step 3: Get list of Azure Compute, Hybrid Compute, and VM Scale Set resources
$computeResources = Get-AzResource | Where-Object {
    $_.ResourceType -like "Microsoft.Compute/virtualMachines" -or
    $_.ResourceType -like "Microsoft.HybridCompute/machines" -or
    $_.ResourceType -like "Microsoft.Compute/virtualMachineScaleSets"
}

if ($computeResources.Count -eq 0) {
    Write-Host "No compute, hybrid compute, or VM scale set resources found in this subscription." -ForegroundColor Yellow
    exit
}

Write-Host "Available Compute, Hybrid Compute, and VM Scale Set Resources:"
$computeResources | ForEach-Object { Write-Host "$($_.Name) [$($_.ResourceType)]" }

# Step 4: Prompt the user to supply a Tag name and Tag value
$tagName = Read-Host "Enter the Tag Name"
$tagValue = Read-Host "Enter the Tag Value"

# Step 5: Ask the user to confirm the values
Write-Host "You are about to apply the following tag to all listed resources:"
Write-Host "Tag Name : $tagName"
Write-Host "Tag Value: $tagValue"
$confirmation = Read-Host "Do you want to proceed? (Y/N)"

if ($confirmation -ne "Y") {
    Write-Host "Operation cancelled by user." -ForegroundColor Red
    exit
}

# Step 6: Apply the tag to each resource
foreach ($resource in $computeResources) {
    $tags = @{}
    if ($resource.Tags) {
        $tags = $resource.Tags
    }
    $tags[$tagName] = $tagValue
    Set-AzResource -ResourceId $resource.ResourceId -Tag $tags -Force
    Write-Host "Tagged $($resource.Name) with $tagName=$tagValue"
}

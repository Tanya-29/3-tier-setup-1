#!/bin/bash

# Azure subscription ID
subscriptionId="YOUR_SUBSCRIPTION_ID"

#ResourceGroupName and ResourceName
resourceGroupName="YOUR_RESOURCE_GROUP_NAME"
resourceName="YOUR_RESOURCE_NAME"

# Get the resource metadata
resourceMetadata=$(az resource show --ids "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachines/$resourceName" --output json)

# Gives the metadata in JSON format
echo "$resourceMetadata"

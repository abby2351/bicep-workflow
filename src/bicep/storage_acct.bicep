


//New-AzResourceGroupDeployment -Name firstbiceptest2 -ResourceGroupName bicepRG -TemplateFile main.bicep -stgacct_name bicepstr -stgacct_sku Standard_LRS

@minLength(3)
@maxLength(19)
param stgacct_name_prefix string
//param stgacct_name string


@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
])
param stgacct_sku string = 'Standard_LRS'

param stgTags object = {
  Environment:'Test'
  Role:'bicepscripted'

}

param location string = resourceGroup().location


//var location = resourceGroup().location
var uniqueID = uniqueString(resourceGroup().id, deployment().name)
var uniqueIDshort = take(uniqueID, 5)
var stgacct_name = '${stgacct_name_prefix}${uniqueIDshort}'


resource storage 'Microsoft.Storage/storageAccounts@2023-05-01'={
  
name: stgacct_name
sku:  {
        name: stgacct_sku
      }
kind:'StorageV2'
location: location
tags: stgTags
properties:{
   accessTier: 'Hot' 
}
}

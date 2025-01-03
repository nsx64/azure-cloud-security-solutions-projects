param virtualMachines_VM_Web_name string = 'VM-Web'
param virtualMachines_VM_Mgmt_name string = 'VM-Mgmt'
param networkSecurityGroups_NSG_name string = 'NSG'
param networkInterfaces_vm_web356_name string = 'vm-web356'
param publicIPAddresses_VM_Web_ip_name string = 'VM-Web-ip'
param networkInterfaces_vm_mgmt288_name string = 'vm-mgmt288'
param publicIPAddresses_VM_Mgmt_ip_name string = 'VM-Mgmt-ip'
param virtualNetworks_vnet_nsg_asg_lab_name string = 'vnet-nsg-asg-lab'
param applicationSecurityGroups_ASG_WebServer_name string = 'ASG-WebServer'
param applicationSecurityGroups_ASG_MgmtServer_name string = 'ASG-MgmtServer'

resource applicationSecurityGroups_ASG_MgmtServer_name_resource 'Microsoft.Network/applicationSecurityGroups@2024-01-01' = {
  name: applicationSecurityGroups_ASG_MgmtServer_name
  location: 'southcentralus'
  properties: {}
}

resource applicationSecurityGroups_ASG_WebServer_name_resource 'Microsoft.Network/applicationSecurityGroups@2024-01-01' = {
  name: applicationSecurityGroups_ASG_WebServer_name
  location: 'southcentralus'
  properties: {}
}

resource publicIPAddresses_VM_Mgmt_ip_name_resource 'Microsoft.Network/publicIPAddresses@2024-01-01' = {
  name: publicIPAddresses_VM_Mgmt_ip_name
  location: 'southcentralus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '13.65.0.74'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_VM_Web_ip_name_resource 'Microsoft.Network/publicIPAddresses@2024-01-01' = {
  name: publicIPAddresses_VM_Web_ip_name
  location: 'southcentralus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '13.65.22.205'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualMachines_VM_Mgmt_name_resource 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: virtualMachines_VM_Mgmt_name
  location: 'southcentralus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_VM_Mgmt_name}_OsDisk_1_823e0d26548843888e0046c51df03b87'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM_Mgmt_name}_OsDisk_1_823e0d26548843888e0046c51df03b87'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_VM_Mgmt_name
      adminUsername: 'vmmgmtservertest'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_mgmt288_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_VM_Web_name_resource 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: virtualMachines_VM_Web_name
  location: 'southcentralus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_VM_Web_name}_OsDisk_1_345e8747e60045898345f21a2c4db806'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM_Web_name}_OsDisk_1_345e8747e60045898345f21a2c4db806'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_VM_Web_name
      adminUsername: 'vmwebservertest'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_web356_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualNetworks_vnet_nsg_asg_lab_name_resource 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: virtualNetworks_vnet_nsg_asg_lab_name
  location: 'southcentralus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_vnet_nsg_asg_lab_name_default.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource networkSecurityGroups_NSG_name_resource 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  name: networkSecurityGroups_NSG_name
  location: 'southcentralus'
  properties: {
    securityRules: [
      {
        name: 'Allow-Web-All'
        id: networkSecurityGroups_NSG_name_Allow_Web_All.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '80'
            '443'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
          destinationApplicationSecurityGroups: [
            {
              id: applicationSecurityGroups_ASG_WebServer_name_resource.id
            }
          ]
        }
      }
      {
        name: 'Allow-RDP-All'
        id: networkSecurityGroups_NSG_name_Allow_RDP_All.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
          destinationApplicationSecurityGroups: [
            {
              id: applicationSecurityGroups_ASG_MgmtServer_name_resource.id
            }
          ]
        }
      }
    ]
  }
}

resource networkSecurityGroups_NSG_name_Allow_RDP_All 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_NSG_name}/Allow-RDP-All'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
    destinationApplicationSecurityGroups: [
      {
        id: applicationSecurityGroups_ASG_MgmtServer_name_resource.id
      }
    ]
  }
  dependsOn: [
    networkSecurityGroups_NSG_name_resource
  ]
}

resource networkSecurityGroups_NSG_name_Allow_Web_All 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_NSG_name}/Allow-Web-All'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    sourceAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '80'
      '443'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
    destinationApplicationSecurityGroups: [
      {
        id: applicationSecurityGroups_ASG_WebServer_name_resource.id
      }
    ]
  }
  dependsOn: [
    networkSecurityGroups_NSG_name_resource
  ]
}

resource virtualNetworks_vnet_nsg_asg_lab_name_default 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_vnet_nsg_asg_lab_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_nsg_asg_lab_name_resource
  ]
}

resource networkInterfaces_vm_mgmt288_name_resource 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: networkInterfaces_vm_mgmt288_name
  location: 'southcentralus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_mgmt288_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.5'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_VM_Mgmt_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_nsg_asg_lab_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationSecurityGroups: [
            {
              id: applicationSecurityGroups_ASG_MgmtServer_name_resource.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_web356_name_resource 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: networkInterfaces_vm_web356_name
  location: 'southcentralus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_web356_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_VM_Web_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_nsg_asg_lab_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationSecurityGroups: [
            {
              id: applicationSecurityGroups_ASG_WebServer_name_resource.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

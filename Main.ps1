# Import the Active Directory module
Import-Module ActiveDirectory

# Set the OU to search for users
$OU = "OU=Users,DC=domain,DC=local"

# Get a list of users in the OU
$users = Get-ADUser -SearchBase $OU -Filter * -Properties Name, UserPrincipalName | Sort-Object Name

# Set the new UPN suffix
$newUPNSuffix = "@domain.local"

# Iterate through the list of users
foreach ($user in $users)
{
    # Get the current UPN of the user
    $currentUPN = $user.UserPrincipalName

    # Replace the current UPN suffix with the new UPN suffix
    $newUPN = $currentUPN.Replace($currentUPN.Split("@")[1], $newUPNSuffix)

    # Set the new UPN for the user
    Set-ADUser -Identity $user -UserPrincipalName $newUPN
}

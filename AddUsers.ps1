$path = "new-users.csv"

Import-Csv $path | Foreach-Object { 

    foreach ($property in $_.PSObject.Properties)
    {
        check-account($property.Name,$property.Value);
    } 
    

}





function check-account($name,$value){
$Search = New-object DirectoryServices.DirectorySearcher

$Search.Filter="(&(objectcategory=Person)(objectclass=User))"

$List = $Search.Findall()

foreach ($user in $List)
{
$username = $user.properties.samaccountname

  if($username == $value)
  {
    write $user.properties.samaccountname
  } 
}
}


#function create-account ([string]$accountName, [string]$accountDescription) {
#$hostname = hostname
#$comp = [adsi]“WinNT://$hostname”
#$user = $comp.Create(“User”, $accountName)
#$user.SetPassword(“change,password.10″)
#$user.SetInfo()
#$user.description = $accountDescription
#$user.SetInfo()
#$User.UserFlags[0] = $User.UserFlags[0] -bor 0×10000 #ADS_UF_DONT_EXPIRE_PASSWD flag is 0×10000
#$user.SetInfo()

#$objOU = [ADSI]“WinNT://$hostname/Administrators,group”
#$objOU.add(“WinNT://$hostname/$accountName”)

#$objOU = [ADSI]“WinNT://$hostname/Remote Desktop Users,group”
#$objOU.add(“WinNT://$hostname/$accountName”)
#}
$Computers = Get-Content -Path "computers.txt"
$Groups = Get-Content -Path "groups.txt"

Foreach($Group in $Groups)
{
    Foreach($Computer in $Computers)
    {
        $ComputerObject = Get-ADComputer $Computer
        $GroupObject = Get-ADGroup $Group

        if ($ComputerObject) {
            if ($GroupObject) {
                Remove-ADGroupMember $Group `
                    -Members (Get-ADComputer $Computer).DistinguishedName -Confirm:$False
                Write-Host " "
                Write-Host "The computer, ""$Computer"", has been removed from the group, ""$Group""." `
                    -ForegroundColor Yellow
                Write-Host " "
            }
            else {
                Write-Host " "
                Write-Host "I could not find the group, ""$Group"", in Active Directory." `
                    -ForegroundColor Red
                Write-Host " "
            }
        }
        else {
            Write-Host " "
            Write-Host "I could not find the computer, $Computer, in Active Directory." `
                -ForegroundColor Red
            Write-Host " "
        }
    }

}
Read-Host
############################################################################### 
#        This script  will copy file & reatin it for 10 days 

###########################Variables######################################### 
#minhas vars
$SIVM =C:\SIVM
$PPROT=C:\Pproteses

#
#Padrão SIVM
$Dname = ((get-date).AddDays(0).toString('yyyyMMdd')) 
$dirName = "SIVM_$Dname"
$dirName2 = "PPROT_$Dname"  
$dir= "F:\Backup\Sistemas" 
$limit = (Get-Date).AddDays(-10) #for Retention 
 
#$Filepath = "\\NetworkPath\Share" 
$filename = "*" 
 
$copyfile = $SIVM + "\" + $filename
$copyfile2 = $PPROT + "\" + $filename  
$destination = $dir + "\" + $dirName + "\" + $filename
$destination2 = $dir + "\" + $dirName2 + "\" + $filename  
 
##########################Backup########################################### 
 
new-item -path $dir -name $dirName -type directory 
 
 
try {  
     
 Copy-item $copyfile $destination 
     
    }  
    catch   
    {   
        Write-Host " – error : $_" -foreground red   
    }

new-item -path $dir -name $dirName2 -type directory

try {  
     
 Copy-item $copyfile2 $destination2
     
    }  
    catch   
    {   
        Write-Host " – error : $_" -foreground red   
    }
 
###########################Recycle########################################## 
 
$path = $dir  
  
Get-ChildItem -Path $path  | Where-Object {   
$_.CreationTime -lt $limit } | Remove-Item -recurse -Force

$path2 = $dir2  
  
Get-ChildItem -Path $path2  | Where-Object {   
$_.CreationTime -lt $limit } | Remove-Item -recurse -Force  
 
##############################################################################

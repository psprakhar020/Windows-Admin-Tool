#Add in the frameworks so that we can create the WPF GUI
Add-Type -AssemblyName presentationframework, presentationcore


#Create empty hashtable into which we will place the GUI objects
$wpf = @{ }


#Grab the content of the Visual Studio xaml file as a string
$inputXML = Get-Content -Path "D:\projects\powershell\repo\WpfApp2\WpfApp2\MainWindow.xaml"
    
#clean up xml there is syntax which Visual Studio 2015 creates which PoSH can't understand
$inputXMLClean = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace 'x:Class=".*?"','' -replace 'd:DesignHeight="\d*?"','' -replace 'd:DesignWidth="\d*?"',''
    
#change string variable into xml
[xml]$xaml = $inputXMLClean

#read xml data into xaml node reader object
$reader = New-Object System.Xml.XmlNodeReader $xaml

#create System.Windows.Window object
$tempform = [Windows.Markup.XamlReader]::Load($reader)

#select each named node using an Xpath expression.
$namedNodes = $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")

#add all the named nodes as members to the $wpf variable, this also adds in the correct type for the objects.
$namedNodes | ForEach-Object {$wpf.Add($_.Name, $tempform.FindName($_.Name))}

cls
$wpf





# Memory issue
$wpf.Memory_button.Add_Click({
$wpf.output.Text = cls
<#
  If (-NOT ([string]::IsNullOrEmpty($wpf.Input.Text)))  {

  Write-Verbose  "Gathering processes from $Computername"  -Verbose

  $Computername  = $wpf.Input.text

  Try  {  #>
  #This will list all the process with high memory in descending order
  $Processes  =   Invoke-Command -ScriptBlock {Get-Process | Sort-Object -property 'WS' -Descending} #-ComputerName $Computername
  $Processes |  Out-GridView
  
  #This will give current used memory in %
$Total_Memory = Invoke-Command -ScriptBlock {gwmi -Class win32_operatingsystem | 
Select-Object @{Name = "MemoryUsage"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}} #-ComputerName $ComputerName.Name

$wpf.output.Text = ($Total_Memory |  Out-String)
 <# 
  }

  Catch  {

  Write-Warning  $_

  }

  }
#>
  })






#CPU issue

$wpf.CPU_button.Add_Click({
$wpf.output.Text = cls

<#
  If (-NOT ([string]::IsNullOrEmpty($wpf.Input.Text)))  {

  Write-Verbose  "Gathering processes from $Computername"  -Verbose

  $Computername  = $wpf.Input.text

  Try  { #>

  #This will list all the process with high CPU in descending order
  
  $Processes  =   Invoke-Command -ScriptBlock {Get-Process | Sort-Object -property 'CPU' -Descending}# -ComputerName $ComputerName
  $Processes |  Out-GridView

  
  #This will give current used memory in %
$Total_CPU = Invoke-Command -ScriptBlock {gwmi win32_processor | Measure-Object -property LoadPercentage -Average | Select Average} #-ComputerName $ComputerName.Name
   
$wpf.output.Text = ($Total_CPU |  Out-String)
<#  
  }

  Catch  {

  Write-Warning  $_

  }

  }
#>
  })





  #Service issue:check service status

  $wpf.check_service.Add_Click({
  $wpf.output.Text = cls
  <#
  If (-NOT ([string]::IsNullOrEmpty($wpf.Input.Text)))  {

  Write-Verbose  "Gathering processes from $Computername"  -Verbose

  $Computername  = $wpf.Input.text
 
  Try  { #> 
  $service = $wpf.input_service.Text
  

  #Current status of the service
  $ser1 = Invoke-Command -ScriptBlock {Get-Service -DisplayName $service} #-ComputerName $ComputerName.Name 
  $ser1 | Out-Gridview	
  
  
  <#}

  Catch  {

  Write-Warning  $_

  }

  }
  
  #>
})




#Service issue:start service

$wpf.start_service.Add_Click({
$wpf.output.Text = cls
  <#
  If (-NOT ([string]::IsNullOrEmpty($wpf.Input.Text)))  {

  Write-Verbose  "Gathering processes from $Computername"  -Verbose

  $Computername  = $wpf.Input.text
 
  Try  { #> 
  $service = $wpf.input_service.Text
 
  
#stop current service
  $ser2 = Invoke-Command -ScriptBlock {Start-Service -DisplayName $service -Verbose} #-ComputerName $ComputerName.Name 
  $ser3 = Invoke-Command -ScriptBlock {Get-Service -DisplayName $service} #-ComputerName $ComputerName.Name 
  $ser3 | Out-Gridview 
  
  
  <#}

  Catch  {

  Write-Warning  $_

  }

  }
  
  #>
})







 

#Disk Space issue

$wpf.Disk_button.Add_Click({
$wpf.output.Text = cls
  <#
  If (-NOT ([string]::IsNullOrEmpty($wpf.Input.Text)))  {

  Write-Verbose  "Gathering processes from $Computername"  -Verbose

  $Computername  = $wpf.Input.text
 
  Try  { #> 

 #check Disk space
 $disk = Invoke-Command -ScriptBlock {gwmi -Class Win32_LogicalDisk | Select-Object DeviceID, @{n="free"; e ={“{0:N2}” -f (($_.Freespace/$_.size)*100)}}} #-ComputerName $ComputerName.Name 

 $disk | Out-Gridview 
  
  
  <#}

  Catch  {

  Write-Warning  $_

  }

  }
  
  #>
})

$wpf.common_tool.ShowDialog() | Out-Null
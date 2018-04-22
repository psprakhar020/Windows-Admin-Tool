# Powershell-WPF_GUI_App

It performs four basic check on any remote server within the domain using the PowerShell Remoting. The backend operation of this application works on PowerShell and the GUI is designed using WPF (Windows Presentation Foundation).

## How does the application works?

The UI is in .xaml format and it is converted into windows understandable object by a set of filters.
Now these objects are mapped to different set of PowerShell scripts. The script work on the basic fundamental of PowerShell remoting.

![](https://i.imgur.com/3U0W0Ll.png)

## Functionality of the application

## 1. Memory Check

Check the Memory status of any remote server in domain and dispaly the name of the process using maximum memory and the total memory space consumed on the server.

![](https://i.imgur.com/trIpRr7.png)

## 2. CPU Check

Check the CPU status of any remote server in domain and dispaly the name of the process using maximum CPU utilization and the total CPU space consumed on the server.

![](https://i.imgur.com/vqlq6Bn.png)

## 3. Service Check

Display the currrent of the enquired service on any remote server.
If need can run "Start Service" to start any stopped service.

![](https://i.imgur.com/hXLS74R.png)

## 4. Disk Check

Displays the current disk space used of any remote server.

![](https://i.imgur.com/la99FE1.png)

## What is PowerShell Remoting?

It is a way to start up boot up PowerShell.exe on any remote computer within the domain.
It works on:
•	Service used: WinRM (Windows Remoting) Service
•	Port Used: Uses WS-MAN (Web services for management) It is a variant of HTTP (But it does not talk on port 80 but used 5985 by default).
•	PowerShell is just one consumer of this service/protocol combo.

## If you think about whether PowerShell Remoting is secure or not?

It is by default enabled in Windows Server 2012 and later. 
The communication done is fully encrypted via Kerberos authentication.

## Steps performed to achieve the application:

1.	Make a normal WPF (Windows Presentation Framework) solution using Microsoft Visual Studio.
2.	Grab the content of the Visual Studio xaml file as a string.
3.	Clean up xml there is syntax which Visual Studio 2015 creates which PowerShell can't understand
4.	Change string variable into xml
5.	Read xml data into xaml node reader object
6.	Create System.Windows.Window object
7.	Add all the named nodes as members to the $wpf variable, this also adds in the correct type for the objects.
8.	Now this $wpf variable contains all the below named input and output functionalities in the snap.
9.  Using these functionalities I have mapped certain PowerShell Scripts.

![](https://i.imgur.com/nFU8JOS.png)


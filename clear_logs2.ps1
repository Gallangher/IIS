fast task

You can create a task that runs daily using Administrative Tools > Task Scheduler.
Set your task to run the following command


forfiles /p "C:\inetpub\logs\LogFiles" /s /m *.* /c "cmd /c Del @path" /d -31


This command is for IIS7, and it deletes all the log files that are one week or older.
You can adjust the number of days by changing the /d arg value.

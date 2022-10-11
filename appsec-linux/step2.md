# Step 2

We have started application ACME Audit on local port 8080 for you:

Acme Audit application is vulnerable to an SQL Injection attack that allows bypassing its authentication mechanism.

Let's try to take advantage of this and login without having an account.

1. Open Acme Audit via your web browser by clicking [HERE]({{TRAFFIC_HOST1_8080}}) (it will open in another browser tab)

2. Enter the following credentials:

    Email: `' or 1=1--` (click on the text to copy)

    Password: whatever password you like

Congratulations - **you just broke into the app!**


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="Pages.WebForm3" %>

<!DOCTYPE html>

<html>

    <head>
        <title>Prueba 3</title>   
        
        <!-- Mobile layout -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/> 

        <!-- Page Style -->     
        <link href="../Styles/PageMobile.css" rel="Stylesheet" type="text/css"/>


        <script type="text/javascript">

        </script>

    </head>

    <body style="margin: 0px">

        <form id="form1" runat="server" style="padding: 20px;">

            <div id="divTest1" style="border: 0px solid #FF0000; clear:both;">

                <div id="divTest1_1" style="border: 0px solid #FF00FF; text-align: center; margin-bottom: 10px;">
                    <asp:TextBox ID="TextBox6" runat="server" Width="99%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

            </div>

            <div id="divTest2" style="border: 0px solid #FF0000; clear:both;">

                <div id="divTest2_1" style="border: 0px solid #00FF00; float: left; text-align: left; width: 49%; margin-bottom: 10px;">
                    <asp:TextBox ID="TextBox7" runat="server" Width="96%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

                <div id="divTest2_2" style="border: 0px solid #0000FF; float: right; text-align: right ; width: 49.5%; margin-bottom: 10px;">
                    <asp:TextBox ID="TextBox8" runat="server" Width="96%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>  
                
            </div>
                      
            <div id="divTest3" style="border: 0px solid #FF6600; clear:both;">
                                
                <div id="divTest3_1" style="border: 0px solid #00FF00; float: left; text-align: left; width: 32%; margin-bottom: 10px; margin-right: 10px;">
                    <asp:TextBox ID="TextBox1" runat="server" Width="95%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

                <div id="divTest3_2" style="border: 0px solid #FF00FF; float: left; text-align: left; width: 32%; margin-bottom: 10px;">
                    <asp:TextBox ID="TextBox2" runat="server" Width="95%" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                </div>
                
                <div id="divTest3_3" style="border: 0px solid #0000FF; float: right; text-align: right; width: 32.5%; margin-bottom: 10px;">
                    <asp:TextBox ID="TextBox3" runat="server" Width="95%" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                </div>
                                
            </div>
       
            <div id="divDivision" style="border: 0px solid #FF0000; clear:both;">
                <asp:Label ID="Label1" runat="server" Text="DIVISION"></asp:Label>
            </div>

            <div id="divTestB1" class="divRow">

                <div id="divTestB1_1" class="divRow11">
                    <asp:TextBox ID="TextBox4" runat="server" Width="99%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

            </div>

            <div id="divTestB2" class="divRow">

                <div id="divTestB2_1" class="divRow21">
                    <asp:TextBox ID="TextBox5" runat="server" Width="96%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

                <div id="divTestB2_2" class="divRow22">
                    <asp:TextBox ID="TextBox9" runat="server" Width="96%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>  
               
            </div>
                      
            <div id="divTestB3" class="divRow">
                                
                <div id="divTestB3_1" class="divRow31">
                    <asp:TextBox ID="TextBox10" runat="server" Width="95%" Font-Names="Arial" Font-Size="Larger"></asp:TextBox>
                </div>

                <div id="divTestB3_2" class="divRow32">
                    <asp:TextBox ID="TextBox11" runat="server" Width="95%" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                </div>
                
                <div id="divTestB3_3" class="divRow33">
                    <asp:TextBox ID="TextBox12" runat="server" Width="95%" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                </div>
                                
            </div>


        </form>
    </body>

</html>

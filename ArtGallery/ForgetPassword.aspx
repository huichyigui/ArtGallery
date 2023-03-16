<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="ArtGallery.ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            font-weight: normal;
            text-align: center;
            font-size: xx-large;
        }

        .auto-style3 {
            text-align: center;
        }

        .auto-style4 {
            font-size: large;
        }

        .auto-style5 {
            color: #FF3300;
        }

        .auto-style6 {
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="login" id="login">
        <br />
        <br />
        <br />
        <br />
        <br />

        <table style="width: 748px">
            <tr>
                <td class="auto-style3">
                    <h1 class="auto-style2">&nbsp;</h1>
                    <h1 class="auto-style2"><strong>Reset Account Password 🔑</strong></h1>
                    <p class="auto-style2">&nbsp;</p>
                </td>
            </tr>
            <tr>
                <td style="font-size: large;" class="auto-style3">Instruction: Please fill in both textboxes, select user type,
                <br />
                    then press the validate button.</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="auto-style3">
                    <br />
                    <asp:TextBox ID="txtResetUserName" runat="server" placeholder="Enter Your Account Username" Font-Bold="True" ForeColor="Black" Height="40px" Width="246px"></asp:TextBox>
                    <br />
                    <asp:Image ID="Image1" runat="server" Height="24px" ImageUrl="~/Images/arroww.png" Width="26px" />
                </td>
            </tr>
            <tr>
                <td style="font-size: large;" class="auto-style3">&nbsp;&nbsp;
                <asp:TextBox ID="txtResetUserEmailAddress" runat="server" placeholder="Enter Your Email Address" Font-Bold="True" ForeColor="Black" Height="40px" Width="246px"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtResetUserEmailAddress" CssClass="auto-style27" ErrorMessage="Do double check the email address format." ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9\\w.]+[@]+[a-zA-Z0-9\\w]+[.]+[a-zA-Z0-9\\w]*$">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size: large; font-weight: 600;" class="auto-style3">As:
                <asp:DropDownList ID="ddlResetAccountType" runat="server" CssClass="auto-style4" ToolTip="Select one.">
                    <asp:ListItem>Art Lover</asp:ListItem>
                    <asp:ListItem>Artist</asp:ListItem>
                </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="font-size: large;" class="auto-style3">&nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="auto-style6" DisplayMode="List" ForeColor="#FF3300" />
                    <br />
                    &nbsp;<asp:Label ID="lblResetAccountError" runat="server" CssClass="auto-style5" Text="Invalid username or email address." Visible="False"></asp:Label>
                    <br />
                    <asp:Button ID="btnResetAccountPW" runat="server" Text="Validate and Reset Password" BackColor="green" ForeColor="White" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='green';" Width="300px" OnClick="btnResetAccountPW_Click" />
                    <br />
                </td>
            </tr>
            <tr>
                <td style="font-size: large;">
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
        </table>
    </section>
</asp:Content>

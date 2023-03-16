<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ArtGallery.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .circle1 {
            position: relative;
            border-radius: 60%;
            animation: move 7s infinite ease-in-out alternate;
        }

        .login {
            min-height: 90vh;
        }

        @keyframes move {
            from {
                transform: translateY(0px);
            }

            to {
                transform: translateY(-20px);
            }
        }

        .auto-style1 {
            height: 79px;
        }

        .auto-style2 {
            font-size: medium;
            color: #CC3300;
        }

        .auto-style3 {
            text-align: center;
        }

        .auto-style4 {
            width: 538px;
        }
    </style>
    <section class="login" id="login">
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Panel ID="Panel1" runat="server" defaultbutton="btnLogin">
            <%--Serve as "Enter" Button--%>
            <table style="width: 748px">
                <tr>
                    <td align="right" class="auto-style4">
                        <div class="circle1">
                            <img src="Images/login-img.jpg" /></div>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <h1 style="font-size: 3.5rem; color: black; text-align: center"><b>Login</b></h1>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="font-size: large; font-weight: 600" class="auto-style3">As&nbsp; 
                                <asp:DropDownList ID="ddlUserType" runat="server" CssClass="dropdown">
                                    <asp:ListItem>Art Lover</asp:ListItem>
                                    <asp:ListItem Value="Artist"></asp:ListItem>
                                </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtUsername" runat="server" Font-Size="11pt" placeholder="Enter Username" Font-Bold="True" ForeColor="Black" Width="350px" Height="35px" autocomplete="off" Required="required"></asp:TextBox>
                                    <br />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    <asp:TextBox ID="txtPassword" runat="server" Font-Size="11pt" TextMode="Password" placeholder="Enter Password" Font-Bold="True" ForeColor="Black" Width="350px" Height="35px" MaxLength="15" Required="required"></asp:TextBox>
                                </td>
                                <td>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkViewPw" runat="server" Font-Size="Medium" Text="&nbsp;Show Password" AutoPostBack="True" OnCheckedChanged="chkViewPw_CheckedChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: medium; font-weight: 600">
                                    <div align="center">
                                        <asp:Button ID="btnLogin" CssClass="btn" runat="server" Text="Login" BackColor="green" ForeColor="White" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='green';" Width="300px" OnClick="btnLogin_Click" />
                                        &nbsp;
                                    <br />
                                        <asp:Label ID="lblError" runat="server" CssClass="auto-style2" Text="Incorrect Username / PW. Try again." Visible="False"></asp:Label>
                                        <br />
                                        <div style="background-color: #EFF3FB; border: 1px solid #C1C1C1;"></div>

                                        <asp:LinkButton ID="LinkButton2" style="margin:5px" runat="server" CssClass="btn" BackColor="#e67e22" ForeColor="White" onmouseover="this.style.backgroundColor='#ffa726';" onmouseout="this.style.backgroundColor='#e67e22';" PostBackUrl="~/ForgetPassword.aspx" Height="33px" Width="280px">Forget Password?</asp:LinkButton>
                                        <br />
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn" BackColor="#0d47a1" ForeColor="White" onmouseover="this.style.backgroundColor='#29b6f6';" onmouseout="this.style.backgroundColor='#0d47a1';" PostBackUrl="~/UserRegistration.aspx" Height="33px" Width="280px">New here?</asp:LinkButton>
                                        <br />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    <div class="test1" style:"display: block;">
        <asp:PlaceHolder ID="AdsPlaceHolder" runat="server"></asp:PlaceHolder>
    </div> 
</asp:Content>

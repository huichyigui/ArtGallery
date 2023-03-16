<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs" Inherits="ArtGallery.UserRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .auto-style6 {
            font-size: small;
        }

        .auto-style7 {
            font-size: small;
            text-align: left;
            width: 394px;
        }

        .auto-style8 {
            font-size: medium;
        }

        .auto-style14 {
            width: 790px;
        }

        .auto-style19 {
            height: 60px;
            width: 394px;
        }

        .auto-style20 {
            height: 20px;
            width: 394px;
        }

        .auto-style21 {
            width: 394px;
        }

        .auto-style22 {
            text-align: center;
            width: 394px;
            height: 68px;
        }

        .auto-style23 {
            text-align: left;
            width: 394px;
            height: 68px;
        }

        .auto-style24 {
            color: #FF0000;
            font-size: medium;
        }

        .auto-style26 {
            font-size: small;
            text-align: center;
            width: 394px;
        }

        #displaymessage {
            display: none;
        }

        .auto-style27 {
            font-size: large;
        }

        .auto-style28 {
            width: 741px;
        }

        .auto-style29 {
            height: 17px;
        }

        .auto-style30 {
            height: 14px;
        }

        .rbl input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }
    </style>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $("#txtDOB").datepicker({
                    dateFormat: "dd/mm/yy",
                    yearRange: "c-80:c+40",
                    inline: true,
                    showAnim: 'fadeIn',
                    changeMonth: true,
                    changeYear: true
                });
            });
        });
    </script>
    <script type="text/javascript">
        function ShowImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=Image1.ClientID%>').prop('src', e.target.result)
                        .width(110)
                        .height(110);
                };
                reader.readAsDataURL(input.files[0]);
            }
            var theControl = document.getElementById("displaymessage");
            theControl.style.display = "block";
        }
    </script>
    <script>
        // For disappearing alert message //
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <section class="register" id="register">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="align-align-self-end" align="right" style="width:890px">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <table class="auto-style14">
            <tr>
                <td colspan="2">
                    <h1 class="heading"><b>User Registration</b> &#129310 </h1>
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:TextBox ID="txtFullName" runat="server" Font-Size="11pt" placeholder="Enter Full Name (eg: Chai Jun Wei)" ToolTip="Enter Full Name" Width="338px" Height="35px" required="required"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtFullName" CssClass="auto-style27" ErrorMessage="Please make sure the name does not contain symbol and numbers." ForeColor="#FF3300" ValidationExpression="(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z\s]$)">*</asp:RegularExpressionValidator>
                </td>
                <td class="auto-style20">
                    <asp:TextBox ID="txtUsername" runat="server" Font-Size="11pt" placeholder="Enter Username (eg: junwei01)" ToolTip="Enter Username" Width="338px" Height="35px" required="required"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:TextBox ID="txtPassword" runat="server" Font-Size="11pt" placeholder="Enter Password (eg: ABC12345)" ToolTip="Enter Password" Width="338px" Height="35px" TextMode="Password" required="required"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPassword" CssClass="auto-style27" ErrorMessage="Minimum 8 characters and contains at least 1 alphabet and 1 number." ForeColor="#FF3300" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">*</asp:RegularExpressionValidator>
                </td>
                <td class="auto-style20">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" Font-Size="11pt" placeholder="Enter Confirm Password" ToolTip="Enter Confirm Password" Width="338px" Height="35px" TextMode="Password" required="required"></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" CssClass="auto-style27" ErrorMessage="Please double check your password" ForeColor="#FF3300">*</asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:TextBox ID="txtMobile" runat="server" Font-Size="11pt" placeholder="Enter Mobile Number (eg: 013-2088131)" ToolTip="Enter Mobile Number" Width="338px" Height="35px" required="required"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtMobile" CssClass="auto-style27" ErrorMessage="At least 10/ 11 contact number only" ForeColor="#FF3300" ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{3,4})$">*</asp:RegularExpressionValidator>
                </td>
                <td class="auto-style20">
                    <asp:TextBox ID="txtEmail" runat="server" Font-Size="11pt" TextMode="Email" placeholder="Enter Email Address (eg: junwei@gmail.com)" ToolTip="Enter Email Address" Width="338px" Height="35px" required="required"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtEmail" CssClass="auto-style27" ErrorMessage="Do double check the email address format." ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9\\w.]+[@]+[a-zA-Z0-9\\w]+[.]+[a-zA-Z0-9\\w]*$">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:TextBox ID="txtAddress" runat="server" Font-Size="11pt" placeholder="Enter Address" ToolTip="Enter Address" Width="338px" Height="34px" TextMode="MultiLine" required="required" Style="padding-top: 10px;"></asp:TextBox>
                </td>
                <td class="auto-style20">
                    <asp:TextBox ID="txtZipCode" runat="server" Font-Size="11pt" placeholder="Enter Zip Code (eg: 99999)" ToolTip="Enter Zip Code" Width="338px" Height="35px" required="required" MaxLength="5"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtZipCode" CssClass="auto-style27" ErrorMessage="5 digits zip code only" ForeColor="#FF3300" ValidationExpression="\d{5}">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style21">
<%--                    <asp:TextBox ID="txtDOB" runat="server" Font-Size="11pt" placeholder="Enter DOB" TextMode="Date" 
                        Width="338px" Height="35px" CssClass="textFormating" required="required"></asp:TextBox>--%>
                    <asp:TextBox ID="txtDOB" runat="server" Font-Size="11pt" Width="338px" Height="35px" CssClass="textFormating" required="required" ClientIDMode="static">Enter DOB</asp:TextBox>
                </td>
                <td style="font-weight: 600" class="auto-style7">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2" class="auto-style30">
                    <div style="background-color: #EFF3FB; border: 1px solid #C1C1C1;" class="auto-style28">
                    </div>
                </td>
            </tr>
            <tr>
                <td class="auto-style29" colspan="2"></td>
            </tr>
            <tr>
                <td class="auto-style21">
                    <strong><span class="auto-style8">&nbsp;Gender:&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:RadioButtonList ID="radGender" runat="server" RepeatLayout="Flow" CellPadding="5" CellSpacing="5" RepeatDirection="Horizontal" CssClass="rbl">
                    <asp:ListItem Selected="True">&nbsp;Male</asp:ListItem>
                    <asp:ListItem>&nbsp;Female</asp:ListItem>
                </asp:RadioButtonList>
                    </span></strong>
                </td>
                <td style="font-weight: 600" class="auto-style7">
                    <strong><span class="auto-style8">Register As:&nbsp;&nbsp; </span></strong>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                    <asp:DropDownList ID="ddlUserType" CssClass="dropdown" runat="server" Height="31px" Width="140px">
                        <asp:ListItem>Art Lover</asp:ListItem>
                        <asp:ListItem>Artist</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style21">
                    <br />
                    <span class="auto-style6" style="font-family:Arial">&nbsp;Upload your profile picture (Optional):</span><br />
                    <asp:FileUpload ID="fuProfileImage" runat="server" Width="338px" onchange="ShowImagePreview(this);" OnServerClick="ShowImagePreview(this);" />
                    <br />
                </td>
                <td style="font-weight: 600" class="auto-style26">
                    <p id="displaymessage">Your Profile Image:</p>
                    <br />
                    <asp:Image ID="Image1" runat="server" Style="border: 1px solid GhostWhite; border-radius: 10px;" />
                    <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style21">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Names="arial" ForeColor="#FF3300" DisplayMode="List" />
                </td>
                <td style="font-weight: 600" class="auto-style7">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="background-color: #EFF3FB; border: 1px solid #C1C1C1;" class="auto-style28">
                    </div>
                </td>

            </tr>
            <tr>
                <td class="auto-style23">
                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="auto-style24"></asp:Label>
                    <br />
                    <asp:Button ID="btnRegister" CssClass="btn" runat="server" Text="Register" BackColor="green" ForeColor="White" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='green';" Width="147px" OnClick="btnRegister_Click" />
                </td>
                <td style="font-size: medium; font-weight: 600" class="auto-style22">&nbsp;&nbsp;<br />

                    Registered before?&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn" Style="padding-top: 10px;" BackColor="#0d47a1" ForeColor="White" onmouseover="this.style.backgroundColor='#29b6f6';" onmouseout="this.style.backgroundColor='#0d47a1';" PostBackUrl="~/Login.aspx" Height="45px" Width="147px" CausesValidation="false"> Login here </asp:LinkButton>
                </td>
            </tr>
        </table>
        <br />
    </section>
</asp:Content>

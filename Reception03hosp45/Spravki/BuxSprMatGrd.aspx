<%@ Page Title="" Language="C#" AutoEventWireup="true"  Inherits="OboutInc.oboutAJAXPage"%>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
 


        <script type="text/javascript">

            var myconfirm = 0;

            function OnBeforeDelete(sender, record) {

                //              alert("myconfirm=" + myconfirm);  
                if (myconfirm == 1) {
                    return true;
                }
                else {
                    document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                    document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                    myConfirmBeforeDelete.Open();
                    return false;
                }
            }

            function findIndex(record) {
                var index = -1;
                for (var i = 0; i < GridMat.Rows.length; i++) {
                    if (GridMat.Rows[i].Cells[0].Value == record.MATIDN) {
                        index = i;
                        //                          alert('index: ' + index);

                        break;
                    }
                }
                return index;
            }

            function ConfirmBeforeDeleteOnClick() {
                myconfirm = 1;
                GridMat.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
                myConfirmBeforeDelete.Close();
                myconfirm = 0;
            }

            function filterGrid(e) {
                var fieldName;
                //        alert("filterGrid=");

                if (e != 'ВСЕ') {
                    fieldName = 'MATNAM';
                    GridMat.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                    GridMat.executeFilter();
                }
                else {
                    GridMat.removeFilter();
                }
            }

   </script>

     
</head>



    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
            //        Grid GridMat = new Grid();

        string BuxSid;
        string BuxFrm;
        string Html;
        int MatIdn;
        int MatKod;
        string MatNam;
        string MatEdn;
        int MatUpk;
        decimal MatZen;
        decimal MatPrz;
        string MatGrp;
        
        string ComParKey = "";
        string ComParTxt = "";
        string ComParPrc = "";
        
        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            GridMat.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridMat.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridMat.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //=====================================================================================
            sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsEdn.SelectCommand = "SELECT EDNNAM FROM SPREDN ORDER BY EDNNAM";

            sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsGrp.SelectCommand = "SELECT GrpMatKod,GrpMatNam FROM SPRGRPMAT ORDER BY GRPMATNAM";
            //=====================================================================================
           if (!Page.IsPostBack)
            {
                string[] alphabet = "А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();
            }
           
            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            
            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {
            //           string NumPrc;

            //            NumPrc = Convert.ToInt32(ComParPrc);
            //           NumPrc = ComParPrc;

            Service1Soap ws = new Service1SoapClient();
            DataSet ds = new DataSet("Menu");
            //       if (ComParKey == null) return;

            if (string.IsNullOrEmpty(ComParKey)) ComParKey="";    // проверка на null и пробел


            //       TxtMat.Text = ComParTxt.PadLeft(100);      // добавляет слева пробел выравнивая общую длину до 1000
            TxtMat.Text = ComParTxt;

            if (ComParKey.Length == 0)
            {
                ds.Merge(ComSelMat(MdbNam, BuxSid, BuxFrm, 0, ComParKey));
                GridMat.DataSource = ds;
                GridMat.DataBind();
            }
            else
                if (ComParKey.Length > 4)
                {
                    ds.Merge(ComSelMat(MdbNam, BuxSid, BuxFrm, 1, ComParKey));
                    GridMat.DataSource = ds;
                    GridMat.DataBind();
                }
                else
                    if (ComParKey.Length < 4)
                    {
                        ds.Merge(ComSelMat(MdbNam, BuxSid, BuxFrm, 2, ComParKey));
                        GridMat.DataSource = ds;
                        GridMat.DataBind();
                    }

        }
                             
        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
 //           MatIdn = Convert.ToInt32(e.Record["MATIDN"]);
            MatNam = Convert.ToString(e.Record["MATNAM"]);

            if (Convert.ToString(e.Record["MATZEN"]) == null || Convert.ToString(e.Record["MATZEN"]) == "") MatZen = 0;
            else MatZen = Convert.ToDecimal(e.Record["MATZEN"]);

            if (Convert.ToString(e.Record["MATPRZ"]) == null || Convert.ToString(e.Record["MATPRZ"]) == "") MatPrz = 0;
            else MatPrz = Convert.ToDecimal(e.Record["MATPRZ"]);

            if (Convert.ToString(e.Record["MATGRP"]) == null || Convert.ToString(e.Record["MATGRP"]) == "") MatGrp =  Convert.ToString(ComParKey);
            else MatGrp = Convert.ToString(e.Record["MATGRP"]);

            if (Convert.ToString(e.Record["MATUPK"]) == null || Convert.ToString(e.Record["MATUPK"]) == "") MatUpk = 0;
            else MatUpk = Convert.ToInt32(e.Record["MATUPK"]);

            if (Convert.ToString(e.Record["MATEDN"]) == null || Convert.ToString(e.Record["MATEDN"]) == "") MatEdn= "штук";
            else MatEdn = Convert.ToString(e.Record["MATEDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprMatAdd", con);
            cmd = new SqlCommand("BuxSprMatAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@MATNAM", SqlDbType.VarChar).Value = MatNam;
            cmd.Parameters.Add("@MATEDN", SqlDbType.VarChar).Value = MatEdn;
            cmd.Parameters.Add("@MATZEN", SqlDbType.VarChar).Value = MatZen;
            cmd.Parameters.Add("@MATPRZ", SqlDbType.VarChar).Value = MatPrz;
            cmd.Parameters.Add("@MATGRP", SqlDbType.VarChar).Value = MatGrp;
            cmd.Parameters.Add("@MATUPK", SqlDbType.Int, 4).Value = MatUpk;
            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            LoadGridNode();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {

            MatIdn = Convert.ToInt32(e.Record["MATIDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprMatDel", con);
            cmd = new SqlCommand("BuxSprMatDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@MATIDN", SqlDbType.Int, 4).Value = MatIdn;
            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            LoadGridNode();

        }

        //------------------------------------------------------------------------
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            MatIdn = Convert.ToInt32(e.Record["MATIDN"]);
            MatNam = Convert.ToString(e.Record["MATNAM"]);

            if (Convert.ToString(e.Record["MATZEN"]) == null || Convert.ToString(e.Record["MATZEN"]) == "") MatZen = 0;
            else MatZen = Convert.ToDecimal(e.Record["MATZEN"]);

            if (Convert.ToString(e.Record["MATPRZ"]) == null || Convert.ToString(e.Record["MATPRZ"]) == "") MatPrz = 0;
            else MatPrz = Convert.ToDecimal(e.Record["MATPRZ"]);

            if (Convert.ToString(e.Record["MATGRP"]) == null || Convert.ToString(e.Record["MATGRP"]) == "") MatGrp =  Convert.ToString(ComParKey);
            else MatGrp = Convert.ToString(e.Record["MATGRP"]);

            if (Convert.ToString(e.Record["MATUPK"]) == null || Convert.ToString(e.Record["MATUPK"]) == "") MatUpk = 0;
            else MatUpk = Convert.ToInt32(e.Record["MATUPK"]);

            if (Convert.ToString(e.Record["MATEDN"]) == null || Convert.ToString(e.Record["MATEDN"]) == "") MatEdn= "штук";
            else MatEdn = Convert.ToString(e.Record["MATEDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprMatRep", con);
            cmd = new SqlCommand("BuxSprMatRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@MATIDN", SqlDbType.Int, 4).Value = MatIdn;
            cmd.Parameters.Add("@MATNAM", SqlDbType.VarChar).Value = MatNam;
            cmd.Parameters.Add("@MATEDN", SqlDbType.VarChar).Value = MatEdn;
            cmd.Parameters.Add("@MATZEN", SqlDbType.VarChar).Value = MatZen;
            cmd.Parameters.Add("@MATPRZ", SqlDbType.VarChar).Value = MatPrz;
            cmd.Parameters.Add("@MATGRP", SqlDbType.VarChar).Value = MatGrp;
            cmd.Parameters.Add("@MATUPK", SqlDbType.Int, 4).Value = MatUpk;
            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            LoadGridNode();
        }
        
        //-------------------------- увеличение высоту полей описание и акции ----------------------------------------------
        // выбор студентов при нажатии на узел дерева
        public DataSet ComSelMat(string BUXMDB, string BUXSID, string BUXFRM, int LENKEY, string TREKEY)
        {
            bool flag;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprMatSel", con);
            cmd = new SqlCommand("BuxSprMatSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BUXSID;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BUXFRM;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LENKEY;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = TREKEY;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxSprMatSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            try
            {
                flag = true;
            }
            // если запись не найден
            catch
            {
                flag = false;
            }
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
            return ds;
        }

        
 </script>   


<body>
    <form id="form1" runat="server">   
<%-- ============================  JAVA ============================================ --%>
  

<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <asp:HiddenField ID="parMatKod" runat="server" />
  <asp:HiddenField ID="parMatNam" runat="server" />

  <input type="hidden" name="hhh" id="par" />
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  
     
    <div>
        <asp:TextBox ID="TxtMat" 
             Text="                                                            Справочник материалов" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>

                        <obout:Grid id="GridMat" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
	         		               AllowAddingRecords = "true"
                             EnableTypeValidation="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false"
                                   AllowPaging="false"
                                   Width="100%"
                                   AllowPageSizeSelection="false" >
                                  <ScrollingSettings ScrollHeight="450" />
                                    <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
                 		    	<Columns>
	                    			<obout:Column ID="Column0" DataField="MATIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column1" DataField="MATKOD" HeaderText="Код" ReadOnly = "true" Align="right" Width="5%" />											
                    				<obout:Column ID="Column2" DataField="MATNAM" HeaderText="Наименование" Width="50%" />
                    				<obout:Column ID="Column3" DataField="MATEDN" HeaderText="Ед.изм" Width="8%" >
                                           <TemplateSettings EditTemplateId="TemplateEditEdn" />
                                    </obout:Column>
                   				    <obout:Column ID="Column4" DataField="MATUPK" HeaderText="В упак." Width="5%" DataFormatString="{0:F0}" Align="right"/>
                   				    <obout:Column ID="Column5" DataField="MATZEN" HeaderText="Цена" Width="10%" DataFormatString="{0:F2}" Align="right"/>
                    				<obout:Column ID="Column6" DataField="MATPRZ" HeaderText="Надбавка"  Width="5%" DataFormatString="{0:F2}"  Align="right"/>
		              				<obout:Column ID="Column7" DataField="MATGRP" HeaderText="Группа" Width="8%" >
	            			              <TemplateSettings TemplateId="TemplateGrp" EditTemplateId="TemplateEditGrp" />
                                    </obout:Column>
		                    		<obout:Column ID="Column8" DataField="" HeaderText="Корр" Width="9%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>

			                    <Templates>	
	                    		  <obout:GridTemplate runat="server" ID="TemplateEdn" >
				                       <Template>
				                            <%# Container.DataItem["EDNNAM"]%>			      		       
				                       </Template>
				                    </obout:GridTemplate>
				                 
                                    <obout:GridTemplate runat="server" ID="TemplateEditEdn" ControlID="ddlEdn" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlEdn" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNNAM">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>	
				                   
	                    		    <obout:GridTemplate runat="server" ID="TemplateGrp" >
				                      <Template>
				                           <%# Container.DataItem["GRPMATNAM"]%>			      		       
				                    </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditGrp" ControlID="ddlGrp" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlGrp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGrp" CssClass="ob_gEC" DataTextField="GRPMATNAM" DataValueField="GRPMATKOD">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>					                   
				                    		                            		                            
	                    		</Templates>
	                    	</obout:Grid>	
 
          <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        
      
              </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
      <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для источника -----------------------------------------------  -->
    <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="SCREEN_CENTER" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>

   </form>

     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
	        font-size: 12px;
         }

 
       /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }

       /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
               

			}
			a.pg:hover {
				color:crimson;
			}
    </style>
   
    </body>
</html>

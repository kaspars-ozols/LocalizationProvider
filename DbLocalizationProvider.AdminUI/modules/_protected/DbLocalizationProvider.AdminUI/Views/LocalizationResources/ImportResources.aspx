﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DbLocalizationProvider.AdminUI.ImportResourcesViewModel>" %>
<%@ Import Namespace="System.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Framework.Web.Mvc.Html"%>
<%@ Import Namespace="EPiServer.Framework.Web.Resources"%>
<%@ Import Namespace="EPiServer.Shell" %>
<%@ Import Namespace="EPiServer.Shell.Navigation" %>
<%@ Import Namespace="EPiServer" %>
<%@ Import Namespace=" EPiServer.Shell.Web.Mvc.Html"%>
<%@ Assembly Name="EPiServer.Shell.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Localization Resources</title>

    <%= Page.ClientResources("ShellCore") %>
    <%= Page.ClientResources("ShellWidgets") %>
    <%= Page.ClientResources("ShellCoreLightTheme") %>
    <%= Page.ClientResources("ShellWidgetsLightTheme")%>
    <%= Page.ClientResources("Navigation") %>
    <%= Page.ClientResources("DijitWidgets", new[] { ClientResourceType.Style })%>
    <%= Html.CssLink(UriSupport.ResolveUrlFromUIBySettings("App_Themes/Default/Styles/ToolButton.css")) %>
    <%= Html.CssLink(Paths.ToClientResource("CMS", "ClientResources/Epi/Base/CMS.css"))%>
    
    <%= Html.ShellAsyncInitializationScript() %>
    
    <%= Html.ScriptResource(UriSupport.ResolveUrlFromUtilBySettings("javascript/episerverscriptmanager.js"))%>
    <%= Html.ScriptResource(UriSupport.ResolveUrlFromUIBySettings("javascript/system.js")) %>
    <%= Html.ScriptResource(UriSupport.ResolveUrlFromUIBySettings("javascript/dialog.js")) %>
    <%= Html.ScriptResource(UriSupport.ResolveUrlFromUIBySettings("javascript/system.aspx")) %>

    <style type="text/css">
        .EP-systemMessage {
            display: block;
            border: solid 1px #878787;
            background-color: #fffdbd;
            padding: 0.3em;
            margin-top: 0.5em;
            margin-bottom: 0.5em;
        }
    </style>

    <script src="//code.jquery.com/jquery-2.0.3.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
    
    <script type="text/javascript">
        function warnUser() {
            var $this = $(this);

            if (!$this.checked) {
                alert('You choose to skip checking only for new content. This will overwrite matched resources and delete unused ones!');
            }
        }
    </script>
</head>
<body>
    <% if (Model.ShowMenu)
       {
           %><%= Html.GlobalMenu() %><%
       } %>
    <div class="epi-contentContainer epi-padding">
        <div class="epi-contentArea epi-paddingHorizontal">
            <h1 class="EP-prefix">Import Localization Resources</h1>
            <form id="backForm" action="<%= Model.ShowMenu ? Url.Action("Main") : Url.Action("Index") %>" method="get"></form>
            <div class="epi-paddingVertical">
                <% if (!string.IsNullOrEmpty(ViewData["LocalizationProvider_ImportResult"] as string))
                   {
                       %>
                <div class="EP-systemMessage">
                    <%= ViewData["LocalizationProvider_ImportResult"] %>
                    <%= Html.ValidationSummary() %>
                </div>
                <%
                   } %>
                <form action="<%= Url.Action("ImportResources") %>" method="post" enctype="multipart/form-data" id="importForm">
                    <input type="hidden" name="showMenu" value="<%= Model.ShowMenu %>"/>
                    <p class="EP-systemInfo">Import localization resources exported from other EPiServer system.</p>
                    <div class="epi-formArea">
                        <div class="epi-paddingVertical-small epi-size20">

                            <div>
                                <label for="importFile">Select file to upload</label>
                                <input name="importFile" type="file" id="importFile" accept=".json"/>
                            </div>

                            <div class="epi-indent">
                                <input type="checkbox" id="importOnlyNewContent" value="true" checked="checked" name="importOnlyNewContent" onchange="warnUser();"/>
                                <label for="importOnlyNewContent">Import only new content</label>
                                <input name="importOnlyNewContent" type="hidden" value="false"/>
                            </div>
                        </div>
                    </div>
                    <div class="epi-buttonContainer">
                        <span class="epi-cmsButton">
                            <input class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Import" type="submit" id="importResources" value="Import" title="Import" />
                        </span>
                        <span class="epi-cmsButton">
                            <input class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-File" type="submit" id="importTestResources" value="Test Import with Log" title="Test Import with Log" disabled="disabled"/>
                        </span>
                        <span class="epi-cmsButton">
                            <input class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Undo" type="button" id="back" value="Back" title="Back" onclick="$('#backForm').submit();" />
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

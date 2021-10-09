using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace voicerecorder
{
    /// <summary>
    /// Summary description for api
    /// </summary>
    public class api : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            jsonSerializer.MaxJsonLength = Int32.MaxValue;
            var jsonString = String.Empty;
            if (context.Request.QueryString["methodname"] != null)
            {
                var methodName = context.Request.QueryString["methodname"].ToLower();
                if(methodName == "audioupload")
                {
                    var httpRequest = HttpContext.Current.Request;

                    if (httpRequest.Files.Count > 0)
                    {
                        var docfiles = new List<string>();
                        foreach (string file in httpRequest.Files)
                        {
                            var postedFile = httpRequest.Files[file];
                            var filePath = HttpContext.Current.Server.MapPath("~/AudioFiles/" + postedFile.FileName + ".mp3");
                            postedFile.SaveAs(filePath);
                            docfiles.Add(filePath);
                        }

                    }
                    var filename = httpRequest.Files[0].FileName;
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
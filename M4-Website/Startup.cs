using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(M4_Website.Startup))]
namespace M4_Website
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

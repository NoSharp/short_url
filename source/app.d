import vibe.vibe;
import std.stdio;


/**
Routes:
	/shrink (returns .dt with url)
	/url (returns website.)
**/

import  vibe.vibe;
import Shorten;


final class Shortner{
    public:
        Shorten[] shortens;
        string url;
        string name;

    void get() {
		render!("index.dt");
	}

    @path("/shortner")
    void postShortner(string url, string name){
        auto shorten = new Shorten(url, name);
        this.shortens ~= shorten;
        logInfo("got called with url: %s", url);
    }

	void get()

	@path("/:id")
    void index(string _id)
	{
		logInfo("got called with A id: %s", _id);
		foreach (Shorten shorte ; shortens){
			logInfo(shorte.url);
			if(shorte.target == _id){
				redirect(shorte.url);
				return;
			}
		}
		logInfo("Found none. %s", _id);
	}

}


void main()
{
	auto router = new URLRouter;
	router.registerWebInterface(new Shortner);
	router.get("*", serveStaticFiles("public/"));


	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	listenHTTP(settings, router);

	//logInfo("Please open http://127.0.0.1:8080/ in your browser.");
	runApplication();
}


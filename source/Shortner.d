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

    @path("/shrink")
    void postShortner(HTTPServerRequest req, HTTPServerResponse res, string url, string name){
        auto shorten = new Shorten(url, name);
        this.shortens ~= shorten;
        logInfo("got called with url: %s", url);
       
        render!("empty.dt");
        res.writeBody("<h1> " ~ name ~ " </h1>");
    }

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

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


    
    void postShortner(string url){
        auto shorten = new Shorten(url, "rick");
        this.shortens ~= shorten;
        redirect(url);
    }

    void getURL(string id){


    }

}
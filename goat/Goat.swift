
import Foundation
import os.log

/**
 * This is the game.
 */
class Goat: NSObject {

    var state:Dictionary<String,String> = Dictionary();
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("goat")

    /**
     * All input is passed in here. You should listen for input here,
     * do stuff and then respond with a message.
     */
    func handle(input:String) -> String {

        if (input == "ok") {
            return say(input: input, message: "Great", options: ["ok"]);
        }

        return say(
            input: input,
            message: "I don't understand",
            options: ["ok", "quit"]
        );
    }


    /*
    init() {
        // self.state = NSKeyedUnarchiver.unarchiveObject(withFile: Goat.ArchiveURL.path) as? [Goat];
    }
    */

    /*
    required convenience init?(coder aDecoder: NSCoder) {
        self.init();
        // ...
    }
    */

    func say(input: String, message:String, options:Array<String>) -> String {
        var response:String = "";

        response += "you> " + input;
        response += "\n\n";
        response += message;
        response += "\n";
        response += "[" + options.joined(separator: ", ") + "]";
        response += "\n";

        return response;
    }


    func encode(with aCoder: NSCoder) {
        // ...
    }

    func save() -> Void {
        NSKeyedArchiver.archiveRootObject(self, toFile: Goat.ArchiveURL.path);
    }

}

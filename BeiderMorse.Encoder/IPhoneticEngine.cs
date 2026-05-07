namespace BeiderMorse.Encoder {
    /// <summary>
    /// Calculates the phonemes and returns a string representation: "Smith" → "smit|xmit|zmit|spit|..."<br/>
    /// To match two encoded strings, see README.md
    /// </summary>
    public interface IPhoneticEngine {
        int MaxCharacters { get; set; }
        string Encode(string input);
    }
}
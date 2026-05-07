namespace BeiderMorse.Encoder
{
    public interface IPhoneticEngine
    {
        int MaxCharacters { get; set; }
        string Encode(string input);
    }
}
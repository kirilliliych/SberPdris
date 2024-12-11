import org.example.BruhClass;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

public class BruhClassTest {
    @Test
    public void testAuthPassed() {
        Assertions.assertEquals("Glory to Saint-Petersburg and this is our city",
                BruhClass.authentication(52));
    }

    @Test
    public void testAuthFailed() {
        Assertions.assertEquals("...? Anything here?...",
                BruhClass.authentication(42));
    }
}

package org.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DeepThoughtSolverTest {
    @Test
    public void getAnswerTest() {
        DeepThoughtSolver solver = new DeepThoughtSolver();

        final int correctAnswer = 42;
        assertEquals(correctAnswer, solver.getAnswer("Какой смысл жизни?"));
        assertEquals(correctAnswer, solver.getAnswer("Что такое вселенная?"));
        assertEquals(correctAnswer, solver.getAnswer(null));
        assertEquals(correctAnswer, solver.getAnswer(new Object()));
        assertEquals(correctAnswer, solver.getAnswer(""));
    }
}
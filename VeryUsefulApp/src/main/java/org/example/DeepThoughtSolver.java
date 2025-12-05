package org.example;

public class DeepThoughtSolver {
    private static final int answer = 42;

    public int getAnswer(Object question) {
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return answer;
    }
}

package org.example;

import java.util.Scanner;

public class DeepThoughtApp {
    private final DeepThoughtSolver solver = new DeepThoughtSolver();
    private final Scanner scanner = new Scanner(System.in);

    public void run() {
        System.out.println("\nЯ знаю Ответ на Главный Вопрос Жизни,");
        System.out.println("Вселенной и Всего такого... Задавайте вопросы!");
        System.out.println("(для выхода введите 'exit')");
        System.out.println("══════════════════════════════════════════");

        while (true) {
            System.out.print("\nВаш вопрос: ");
            String input = scanner.nextLine().trim();

            if (input.equalsIgnoreCase("exit")) {
                break;
            }

            if (input.isEmpty()) {
                continue;
            }

            int answer = solver.getAnswer(input);

            System.out.println("   Ответ: " + answer);
        }
        scanner.close();
    }
}

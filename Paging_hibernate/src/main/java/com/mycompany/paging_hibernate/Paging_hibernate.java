package com.mycompany.paging_hibernate;

import java.util.List;
import java.util.Scanner;
import org.hibernate.Session;
import org.hibernate.query.Query;

/**
 *
 * @author perpi
 */
public class Paging_hibernate {

    public static void main(String[] args) {
        Session laSesion = HibernateUtil.getSessionFactory().getCurrentSession();
        laSesion.getTransaction().begin();

        int actual_page = 1;
        int maxResults = 8;
        //=========================Calcular total páginas============================
        Query<Long> countQuery = laSesion.createQuery("select count(*) from Persona", Long.class);
        long totalPersons = countQuery.uniqueResult();
        long totalPages = (totalPersons + maxResults - 1) / maxResults;
        boolean more_results = true;
        while (more_results) {
            //=========================Query============================
            Query<Persona> query = laSesion.createQuery("from Persona", Persona.class);
            int firstResult = (actual_page - 1) * maxResults;
            query.setFirstResult(firstResult);
            query.setMaxResults(maxResults);
            List<Persona> personaList = personaList = query.list();
            System.out.println("============================================================================");
            for (Persona persona : personaList) {
                System.out.println(persona.toString());
            }
            System.out.println("\nPage " + actual_page + " of " + totalPages);
            System.out.println("         <S. Next>    <A. Previous>    <G n. Go to n>    <Q. Exit>");

            //=========================Prompt============================
            Scanner scanner = new Scanner(System.in);
            String option = scanner.nextLine().toUpperCase();
            System.out.println("");
            switch (option) {
                case "S":
                    if (actual_page < totalPages) {
                        actual_page++;
                    }
                    break;
                case "A":
                    if (actual_page > 1) {
                        actual_page--;
                    }
                    break;
                case "Q":
                    more_results = false;
                    break;
                default:
                    if (option.startsWith("G ")) {
                        int page = Integer.parseInt(option.substring(2));
                        if (page >= 1 && page <= totalPages) {
                            actual_page = page;
                        } else {
                            System.out.println("Invalid page number.");
                        }
                    }
                    break;

            }
        }

    }
}

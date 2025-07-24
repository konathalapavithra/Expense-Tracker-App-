package com.expensetracker.service;

import com.expensetracker.model.Expense;
import com.expensetracker.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExpenseService {

    @Autowired
    private ExpenseRepository expenseRepository;

    public List<Expense> getAllExpenses() {
        return expenseRepository.findAll();
    }

    public Expense createExpense(Expense expense) {
        return expenseRepository.save(expense);
    }

    public Expense updateExpense(Long id, Expense updatedExpense) {
        Optional<Expense> existingExpense = expenseRepository.findById(id);
        if (existingExpense.isPresent()) {
            Expense exp = existingExpense.get();
            exp.setTitle(updatedExpense.getTitle());
            exp.setAmount(updatedExpense.getAmount());
            exp.setDate(updatedExpense.getDate());
            exp.setCategory(updatedExpense.getCategory());
            return expenseRepository.save(exp);
        } else {
            return null;
        }
    }

    public void deleteExpense(Long id) {
        expenseRepository.deleteById(id);
    }
}
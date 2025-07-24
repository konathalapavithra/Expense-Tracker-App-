package com.expensetracker.service;

import com.expensetracker.model.Reminder;
import com.expensetracker.repository.ReminderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReminderService {

    @Autowired
    private ReminderRepository reminderRepository;

    public List<Reminder> getAllReminders() {
        return reminderRepository.findAll();
    }

    public Reminder addReminder(Reminder reminder) {
        return reminderRepository.save(reminder);
    }
}
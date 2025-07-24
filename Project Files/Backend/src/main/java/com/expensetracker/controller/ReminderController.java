package com.expensetracker.controller;

import com.expensetracker.model.Reminder;
import com.expensetracker.service.ReminderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reminders")
@CrossOrigin(origins = "*")
public class ReminderController {

    @Autowired
    private ReminderService reminderService;

    @GetMapping
    public List<Reminder> getReminders() {
        return reminderService.getAllReminders();
    }

    @PostMapping
    public Reminder addReminder(@RequestBody Reminder reminder) {
        return reminderService.addReminder(reminder);
    }
}
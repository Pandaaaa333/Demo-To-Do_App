import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/todo.dart';
import '../viewmodels/bloc/todo_bloc.dart';
import '../viewmodels/bloc/todo_event.dart';

class TodoItemCard extends StatelessWidget {
  final Todo todo;

  const TodoItemCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) {
        context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white, // White card
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              final updatedTodo = Todo(
                id: todo.id,
                title: todo.title,
                isCompleted: !todo.isCompleted,
              );
              context.read<TodoBloc>().add(UpdateTodoEvent(updatedTodo));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Custom Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: todo.isCompleted ? const Color(0xFF10B981) : Colors.transparent, // Emerald 500
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: todo.isCompleted ? const Color(0xFF10B981) : Colors.black26,
                        width: 2,
                      ),
                    ),
                    child: todo.isCompleted
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  // Title
                  Expanded(
                    child: Text(
                      todo.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: todo.isCompleted ? Colors.black45 : Colors.black87,
                        decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

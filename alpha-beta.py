import math

def minimax_alpha_beta(node, depth, alpha, beta, maximizing_player):
    if depth == 0 or node.is_terminal():
        return node.evaluate(), None

    if maximizing_player:
        max_eval = -math.inf
        best_move = None
        for move in node.get_possible_moves():
            child_node = node.make_move(move)
            eval, _ = minimax_alpha_beta(child_node, depth - 1, alpha, beta, False)
            if eval > max_eval:
                max_eval = eval
                best_move = move
            alpha = max(alpha, eval)
            if beta <= alpha:
                break
        return max_eval, best_move
    else:
        min_eval = math.inf
        best_move = None
        for move in node.get_possible_moves():
            child_node = node.make_move(move)
            eval, _ = minimax_alpha_beta(child_node, depth - 1, alpha, beta, True)
            if eval < min_eval:
                min_eval = eval
                best_move = move
            beta = min(beta, eval)
            if beta <= alpha:
                break
        return min_eval, best_move

# Example usage:

class Node:
    def _init_(self, value):
        self.value = value

    def is_terminal(self):
        # Check if the node is a terminal node
        return True

    def evaluate(self):
        # Evaluate the node
        return self.value

    def get_possible_moves(self):
        # Get possible moves from the current node
        return []

    def make_move(self, move):
        # Make a move from the current node and return the resulting node
        return Node(self.value + move)

# Create a root node
root_node = Node(0)

# Perform alpha-beta pruning
best_score, best_move = minimax_alpha_beta(root_node, 3, -math.inf, math.inf, True)

print("Best Score:", best_score)
print("Best Move:", best_move)
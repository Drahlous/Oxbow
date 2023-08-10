"""Functions for translating cflow graphs to Mermaid diagrams."""
from typing import List, Dict
from collections import defaultdict

def lines_to_graph(cflow_lines: List[str]) -> Dict:
    """Return caller-callee graph by translating lines read from cflow output."""
    parent = None
    previous = None
    previous_indent = 0
    cflow_graph = defaultdict(list)
    for line in cflow_lines:
        leading_spaces = len(line) - len(line.lstrip())
        current = line.lstrip().split(' ')[0].strip()
        current = current.replace("()", "")

        # If we are not indented at all, we have no parent
        if leading_spaces == 0:
            parent = None

        # If we are more indented than the last line, that is our parent
        if leading_spaces > previous_indent:
            parent = previous

        # If we have a parent, append ourself to their called items
        if parent is not None:
            cflow_graph[parent].append(current)

        previous = current
        previous_indent = leading_spaces

    return cflow_graph

def graph_to_mermaid(direct_graph: Dict[str, list[str]]):
    """Print a Mermaid flowchart by reading from a caller-callee graph."""
    print('```mermaid')
    print('flowchart LR')
    for key, callees in direct_graph.items():
        for callee in callees:
            print(f'{key} --> {callee}')
    print('```')


if __name__ == "__main__":
    with open("graph.txt", "r", encoding="utf-8") as file:
        lines = file.readlines()
        graph = lines_to_graph(lines)
        graph_to_mermaid(graph)

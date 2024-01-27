function [T, cost] = prim_mst(G)
% G is a matrix representing a weighted graph
% T is the minimum spanning tree
% cost is the total weight of the minimum spanning tree

n = size(G, 1);
visited = false(n, 1);
visited(1) = true;
T = zeros(n-1, 2);
cost = 0;
edge_count = 0;

while edge_count < n-1
    min_cost = inf;
    u = 0;
    v = 0;
    for i = 1:n
        if visited(i)
            for j = 1:n
                if ~visited(j) && G(i,j)
                    if G(i,j) < min_cost
                        min_cost = G(i,j);
                        u = i;
                        v = j;
                    end
                end
            end
        end
    end
    visited(v) = true;
    edge_count = edge_count + 1;
    T(edge_count,:) = [u, v];
    cost = cost + min_cost;
end
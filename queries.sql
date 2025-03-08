
INSERT INTO "users" ("id", "name", "mail", "password", "rating")
VALUES
    (1, 'Alice Johnson', 'alice@example.com', 'hashed_password_1', 1200),
    (2, 'Bob Smith', 'bob@example.com', 'hashed_password_2', 1500),
    (3, 'Charlie Brown', 'charlie@example.com', 'hashed_password_3', 1100),
    (4, 'David Miller', 'david@example.com', 'hashed_password_4', 1750),
    (5, 'Emma Wilson', 'emma@example.com', 'hashed_password_5', 950),
    (6, 'Frank Thomas', 'frank@example.com', 'hashed_password_6', 2000),
    (7, 'Grace Hall', 'grace@example.com', 'hashed_password_7', 1350),
    (8, 'Henry Clark', 'henry@example.com', 'hashed_password_8', 1600),
    (9, 'Isabella Young', 'isabella@example.com', 'hashed_password_9', 1800),
    (10, 'Jack White', 'jack@example.com', 'hashed_password_10', 1200);



INSERT INTO "participants" ("id", "name", "users")
VALUES
    (11, 'Alpha Coders', 2),  -- participant with 2 members(team)
    (12, 'Byte Masters', 3),  -- participant with 3 members(team)
    (13, 'Code Warriors', 2),
    (14, 'Dev Dynamos', 3),
    (15, 'Elite Hackers', 2);
INSERT INTO "user_participants" ("user_id", "participant_id")
VALUES
    -- Alpha Coders (participant ID: 11)
    (1, 11),
    (2, 11),

    -- Byte Masters (participant ID: 12)
    (3, 12),
    (4, 12),
    (5, 12),

    -- Code Warriors (participant ID: 13)
    (6, 13),
    (7, 13),

    -- Dev Dynamos (participant ID: 14)
    (8, 14),
    (9, 14),
    (10, 14),

    -- Elite Hackers (participant ID: 15)
    (1, 15),
    (3, 15);
--creating a competition of 3 hours long
INSERT INTO "competitions" ("id", "creator_id", "name", "duration", "starting_time", "ending_time", "penalty_time")
VALUES (1, 2, 'Hackathon Challenge', 180, '2025-02-15 10:00:00', '2025-02-15 13:00:00', 20);

--inserting the users into the competition
INSERT INTO "participants_competitions" ("competition_id", "participant_id")
SELECT 1, "id" FROM "participants";

UPDATE "participants_competitions"
SET "score" = 500, "rank" = 1
WHERE "participant_id" = 11;
UPDATE "participants_competitions"
SET "score" = 400, "rank" = 2
WHERE "participant_id" = 12;
UPDATE "participants_competitions"
SET "score" = 300, "rank" = 3
WHERE "participant_id" = 13;
UPDATE "participants_competitions"
SET "score" = 200, "rank" = 4
WHERE "participant_id" = 14;
UPDATE "participants_competitions"
SET "score" = 100, "rank" = 5
WHERE "participant_id" = 15;

--inserting all the topics of a competitive programming problem
INSERT INTO "topics" ("id", "name") VALUES
    (1, 'implementation'),
    (2, 'greedy'),
    (3, 'math'),
    (4, 'dp'),
    (5, 'data structures'),
    (6, 'graphs'),
    (7, 'trees'),
    (8, 'strings'),
    (9, 'number theory'),
    (10, 'combinatorics'),
    (11, 'geometry'),
    (12, 'bit manipulation'),
    (13, 'two pointers'),
    (14, 'binary search'),
    (15, 'dfs and similar'),
    (16, 'bfs and similar'),
    (17, 'shortest paths'),
    (18, 'sortings'),
    (19, 'divide and conquer'),
    (20, 'brute force'),
    (21, 'constructive algorithms'),
    (22, 'hashing'),
    (23, 'probabilities'),
    (24, 'games'),
    (25, 'flows'),
    (26, 'interactive'),
    (27, 'matrices'),
    (28, 'fft'),
    (29, 'ternary search'),
    (30, 'meet-in-the-middle'),
    (31, 'dsu'),
    (32, 'expression parsing'),
    (33, 'graph matchings'),
    (34, 'schedules'),
    (35, 'string suffix structures'),
    (36, 'chinese remainder theorem'),
    (37, 'schedules'),
    (38, '2-sat'),
    (39, 'expression parsing'),
    (40, 'ternary search'),
    (41, 'meet-in-the-middle'),
    (42, 'fft'),
    (43, 'matrices'),
    (44, 'flows'),
    (45, 'games'),
    (46, 'probabilities'),
    (47, 'hashing'),
    (48, 'constructive algorithms'),
    (49, 'brute force'),
    (50, 'divide and conquer'),
    (51, 'sortings'),
    (52, 'shortest paths'),
    (53, 'bfs and similar'),
    (54, 'dfs and similar'),
    (55, 'binary search'),
    (56, 'two pointers'),
    (57, 'bit manipulation'),
    (58, 'geometry'),
    (59, 'combinatorics'),
    (60, 'number theory'),
    (61, 'strings'),
    (62, 'trees'),
    (63, 'graphs'),
    (64, 'data structures'),
    (65, 'dp'),
    (66, 'math'),
    (67, 'greedy'),
    (68, 'implementation');


--inserting a problem for the competition Hackathon challenge
INSERT INTO "problems" ("id", "competition_id", "label", "name", "time_limit", "memory_limit","content")
VALUES(1,1,'A','Object Identification', 2000, 256,
'This is an interactive problem.

You are given an array x1,…,xn
 of integers from 1
 to n
. The jury also has a fixed but hidden array y1,…,yn
 of integers from 1
 to n
. The elements of array y
 are unknown to you. Additionally, it is known that for all i
, xi≠yi
, and all pairs (xi,yi)
 are distinct.

The jury has secretly thought of one of two objects, and you need to determine which one it is:

Object A: A directed graph with n
 vertices numbered from 1
 to n
, and with n
 edges of the form xi→yi
.
Object B: n
 points on a coordinate plane. The i
-th point has coordinates (xi,yi)
.
To guess which object the jury has thought of, you can make queries. In one query, you must specify two numbers i,j
 (1≤i,j≤n,i≠j)
. In response, you receive one number:

If the jury has thought of Object A, you receive the length of the shortest path (in edges) from vertex i
 to vertex j
 in the graph, or 0
 if there is no path.
If the jury has thought of Object B, you receive the Manhattan distance between points i
 and j
, that is |xi−xj|+|yi−yj|
.
You have 2
 queries to determine which of the objects the jury has thought of.

Input
Each test contains multiple test cases. The first line contains the number of test cases t
 (1≤t≤1000
). The description of the test cases follows.

Interaction
The interaction begins with reading n
 (3≤n≤2⋅105
) — the length of the arrays x
 and y
 at the start of each test case.

Next, read n
 integers: x1,x2,…,xn
 (1≤xi≤n
) — the elements of array x
.

It is guaranteed that the sum of n
 across all test cases does not exceed 2⋅105
.

The array y1,y2,…,yn
 is fixed for each test case. In other words, the interactor is not adaptive.

It is guaranteed that xi≠yi
 for all 1≤i≤n
, and all pairs (xi,yi)
 are distinct.

To make a query, output "? i
 j
" (without quotes, 1≤i,j≤n,i≠j
). Then you must read the response to the query, which is a non-negative integer.

To give an answer, output "! A" if Object A is hidden or "! B" if Object B is hidden (without quotes). Note that printing the answer does not count as one of the 2
 queries.

After printing each query do not forget to output the end of line and flush∗
 the output. Otherwise, you will get Idleness limit exceeded verdict. If, at any interaction step, you read −1
 instead of valid data, your solution must exit immediately. This means that your solution will reveive Wrong answer because of an invalid query or any other mistake. Failing to exit can result in an arbitrary verdict because your solution will continue to read from a closed stream. Note that if the query is correct, the response will never be −1
.

Hacks

The first line must contain an integer t
 (1≤t≤1000
) — the number of test cases.

The first line of each test case must contain an integer n
 (3≤n≤2⋅105
) — the length of the hidden array.

The second line of each test case must contain n
 integers — x1,x2,…,xn
 (1≤xi≤n
).

The third line of each test case must contain n
 integers — y1,y2,…,yn
 (1≤yi≤n
).

It must be ensured that xi≠yi
 for all 1≤i≤n
, and all pairs (xi,yi)
 must be distinct.

The fourth line must contain one character: A or B, indicating which of the objects you want to hide.

The sum of n
 across all test cases must not exceed 2⋅105
.

∗
To flush, use:

fflush(stdout) or cout.flush() in C++;
sys.stdout.flush() in Python;
see the documentation for other languages.');


--Inserting the test_cases for the problem id = 1
INSERT INTO "test_cases"("id", "problem_id" , "input", "output", "explanation","hidden")
VALUES (1,1,
'2
3
2 2 3

1

0

5
5 1 4 2 3

4

4',
'? 2 3

? 1 2

! A

? 1 5

? 5 1

! B',
'In the first test case, x=[2,2,3]
, y=[1,3,1]
 and Object A is guessed.

In the second test case, x=[5,1,4,2,3]
, y=[3,3,2,4,1]
 and Object B is guessed.',
 0);



--Inserting the problem topics  (tags)  of  the problem id  = 1
INSERT INTO "problems_topics" ("problem_id", "topic_id")
VALUES
    (1, (SELECT id FROM topics WHERE name = 'graphs')),
    (1, (SELECT id FROM topics WHERE name = 'greedy')),
    (1, (SELECT id FROM topics WHERE name = 'implementation')),
    (1, (SELECT id FROM topics WHERE name = 'interactive'));

--Inserting submissions for the problem with id = 1
INSERT INTO "submissions"("id","participant_id","problem_id", "language", "judgement", "code")
VALUES(1, 11, 1, 'cpp','accepted',
'//Author: Kevin
#include<bits/stdc++.h>
//#pragma GCC optimize("O2")
using namespace std;
#define ll long long
#define ull unsigned ll
#define pb emplace_back
#define mp make_pair
#define ALL(x) (x).begin(),(x).end()
#define rALL(x) (x).rbegin(),(x).rend()
#define srt(x) sort(ALL(x))
#define rev(x) reverse(ALL(x))
#define rsrt(x) sort(rALL(x))
#define sz(x) (int)(x.size())
#define inf 0x3f3f3f3f
#define pii pair<int,int>
#define lb(v,x) (int)(lower_bound(ALL(v),x)-v.begin())
#define ub(v,x) (int)(upper_bound(ALL(v),x)-v.begin())
#define uni(v) v.resize(unique(ALL(v))-v.begin())
#define longer __int128_t
void die(string S){puts(S.c_str());exit(0);}
int vis[200200];
int x[200200];
int main()
{
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);
	int t;
	cin>>t;
	while(t--)
	{
		int n;
		cin>>n;
		for(int i=1;i<=n;i++)
			vis[i]=0;
		for(int i=1;i<=n;i++)
		{
			cin>>x[i];
			vis[x[i]]=1;
		}
		int p=-1;
		for(int i=1;i<=n;i++)
			if(!vis[i])
				p=i;
		if(~p)
		{
			cout<<"? "<<p<<" "<<p%n+1<<endl;
			int x;
			cin>>x;
			if(x)
				cout<<"! B"<<endl;
			else
				cout<<"! A"<<endl;
		}
		else
		{
			int p1=min_element(x+1,x+n+1)-x;
			int p2=max_element(x+1,x+n+1)-x;
			int a,b;
			cout<<"? "<<p1<<" "<<p2<<endl;
			cin>>a;
			cout<<"? "<<p2<<" "<<p1<<endl;
			cin>>b;
			if(a==b&&a>=n-1)
				cout<<"! B"<<endl;
			else
				cout<<"! A"<<endl;
		}
	}
	return 0;
}');

--testing "no_code_duplication" trigger
--just changing the submission id here but leaving same code for the same problem from the same participant
INSERT INTO "submissions"("id","participant_id","problem_id", "language", "judgement", "code")
VALUES(2, 11, 1, 'cpp','accepted',
'//Author: Kevin
#include<bits/stdc++.h>
//#pragma GCC optimize("O2")
using namespace std;
#define ll long long
#define ull unsigned ll
#define pb emplace_back
#define mp make_pair
#define ALL(x) (x).begin(),(x).end()
#define rALL(x) (x).rbegin(),(x).rend()
#define srt(x) sort(ALL(x))
#define rev(x) reverse(ALL(x))
#define rsrt(x) sort(rALL(x))
#define sz(x) (int)(x.size())
#define inf 0x3f3f3f3f
#define pii pair<int,int>
#define lb(v,x) (int)(lower_bound(ALL(v),x)-v.begin())
#define ub(v,x) (int)(upper_bound(ALL(v),x)-v.begin())
#define uni(v) v.resize(unique(ALL(v))-v.begin())
#define longer __int128_t
void die(string S){puts(S.c_str());exit(0);}
int vis[200200];
int x[200200];
int main()
{
	ios_base::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);
	int t;
	cin>>t;
	while(t--)
	{
		int n;
		cin>>n;
		for(int i=1;i<=n;i++)
			vis[i]=0;
		for(int i=1;i<=n;i++)
		{
			cin>>x[i];
			vis[x[i]]=1;
		}
		int p=-1;
		for(int i=1;i<=n;i++)
			if(!vis[i])
				p=i;
		if(~p)
		{
			cout<<"? "<<p<<" "<<p%n+1<<endl;
			int x;
			cin>>x;
			if(x)
				cout<<"! B"<<endl;
			else
				cout<<"! A"<<endl;
		}
		else
		{
			int p1=min_element(x+1,x+n+1)-x;
			int p2=max_element(x+1,x+n+1)-x;
			int a,b;
			cout<<"? "<<p1<<" "<<p2<<endl;
			cin>>a;
			cout<<"? "<<p2<<" "<<p1<<endl;
			cin>>b;
			if(a==b&&a>=n-1)
				cout<<"! B"<<endl;
			else
				cout<<"! A"<<endl;
		}
	}
	return 0;
}');


--inserting a wrong answer verdict submission
INSERT INTO "submissions"("id","participant_id","problem_id", "language", "judgement", "code")
VALUES(2, 12, 1, 'cpp','wrong_answer',
'// fb505c4a-fa31-41a2-9090-d521a1c26946
#include <iostream>
#include <vector>
using namespace std;

void solve() {
    int n;
    cin >> n;
    vector<int> x(n);
    for(int i = 0; i < n; i++) {
        cin >> x[i];
    }

    // Make two queries and compare their results
    cout << "? 1 2" << endl;
    cout.flush();
    int res1;
    cin >> res1;

    cout << "? 2 1" << endl;
    cout.flush();
    int res2;
    cin >> res2;

    // For Manhattan distance (Object B):
    // |x1-x2| + |y1-y2| = |x2-x1| + |y2-y1|
    // So res1 will always equal res2

    // For graph (Object A):
    // Path length from 1->2 might be different from 2->1
    // So if res1 != res2, it must be a graph

    if(res1 != res2) {
        cout << "! A" << endl;
    } else {
        cout << "! B" << endl;
    }
    cout.flush();
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int t;
    cin >> t;
    while(t--) {
        solve();
    }
    return 0;
}');
-- inserting submission
INSERT INTO "submissions"("id","participant_id","problem_id", "language", "judgement", "code")
VALUES(3, 12, 1, 'cpp','accepted',
'#include <bits/stdc++.h>

using namespace std;

void solve() {
    int n;
    cin >> n;
    vector<int> x(n + 1), isx(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> x[i];
        isx[x[i]] = 1;
    }
    if (accumulate(isx.begin(), isx.end(), 0) == n) {
        int i1 = 0, in = 0;
        for (int i = 1; i <= n; i++) {
            if (x[i] == 1) {
                i1 = i;
            }
            if (x[i] == n) {
                in = i;
            }
        }
        cout << "? " << i1 << " " << in << endl;
        int ans;
        cin >> ans;
        if (ans < n - 1) {
            cout << "! A" << endl;
        } else if (ans > n - 1) {
            cout << "! B" << endl;
        } else {
            cout << "? " << in << "" << i1 << endl;
            cin >> ans;
            if (ans == n - 1) {
                cout << "! B" << endl;
            } else {
                cout << "! A" << endl;
            }
        }
    } else {
        for (int i = 1; i <= n; i++) {
            if (!isx[i]) {
                cout << "? " << i << " " << 1 + (i == 1) << endl;
                int ans;
                cin >> ans;
                if (ans == 0) {
                    cout << "! A" << endl;
                } else {
                    cout << "! B" << endl;
                }
                return;
            }
        }
    }

}

signed main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    int t;
    cin >> t;
    while (t--) {
        solve();
    }
}
');
--inserting a problem for the competition Hackathon challenge
INSERT INTO "problems" ("id", "competition_id", "label", "name", "time_limit", "memory_limit","content")
VALUES(2,1,'B','Three-Dimensional Embedding', 2000, 1024,
'An embedding of a graph in a space is a way of placing each vertex at a distinct point in that space
and drawing each edge as a simple arc connecting its two vertices, so that no two arcs intersect except
at a shared vertex. In this problem, we focus on embeddings in a three-dimensional space under certain
conditions.
You are given a simple undirected graph with n vertices and m edges, which means there is at most one
edge connecting any pair of vertices and each edge connects different vertices. The vertices are numbered
from 1 to n, and the edges are numbered from 1 to m. Edge j connects the two distinct vertices vj and
wj . Each vertex is incident to at most five edges.
Find an embedding of the graph such that all of the following conditions are satisfied.
• Each vertex i is embedded as a point (xi
, yi
, 0) in the space. The coordinates xi and yi must be
integers between 0 and 400, inclusive. All points must have distinct coordinates.
• Each edge j is embedded as a polyline (a connected series of line segments) with the embedded
points for vertices vj and wj as its endpoints. Each segment of the polyline must be parallel to
the x-, y-, or z-axis. Each node of the polyline must have integer coordinates between 0 and 400,
inclusive. Each polyline must have no more than 30 nodes, counting its endpoints.
• Polylines must not have self-intersections. Distinct polylines must not share any point, except when
they correspond to edges incident to the same vertex. In that case, they may share only that single
endpoint.


');


INSERT INTO "test_cases"("id", "problem_id" , "input", "output", "explanation","hidden")
VALUES (3,2,
'3 3
1 2
1 3
2 3
',
'0 0
400 0
0 399
3 0 0 0 100 0 0 400 0 0
4 0 0 0 0 0 200 0 399 200 0 399 0
3 400 0 0 400 399 0 0 399 0',
'Notes on special judging:
You are provided with a command-line tool for local testing. You can download the file from the contest
materials. The tool has comments at the top to explain its use.
Explanation for the sample input/output #1
Figure 1 illustrates the embedding represented by the sample output',
 0);


UPDATE "problems"
SET "content" = 'An embedding of a graph in a space is a way of placing each vertex at a distinct point in that space
and drawing each edge as a simple arc connecting its two vertices, so that no two arcs intersect except
at a shared vertex. In this problem, we focus on embeddings in a three-dimensional space under certain
conditions.
You are given a simple undirected graph with n vertices and m edges, which means there is at most one
edge connecting any pair of vertices and each edge connects different vertices. The vertices are numbered
from 1 to n, and the edges are numbered from 1 to m. Edge j connects the two distinct vertices vj and
wj . Each vertex is incident to at most five edges.
Find an embedding of the graph such that all of the following conditions are satisfied.
• Each vertex i is embedded as a point (xi
, yi
, 0) in the space. The coordinates xi and yi must be
integers between 0 and 400, inclusive. All points must have distinct coordinates.
• Each edge j is embedded as a polyline (a connected series of line segments) with the embedded
points for vertices vj and wj as its endpoints. Each segment of the polyline must be parallel to
the x-, y-, or z-axis. Each node of the polyline must have integer coordinates between 0 and 400,
inclusive. Each polyline must have no more than 30 nodes, counting its endpoints.
• Polylines must not have self-intersections. Distinct polylines must not share any point, except when
they correspond to edges incident to the same vertex. In that case, they may share only that single
endpoint.
Input
The first line of input contains two integers n and m (2 ≤ n ≤ 1600, 1 ≤ m ≤ 4000). The j-th of the
following m lines contains two integers vj and wj (1 ≤ vj < wj ≤ n).
The input guarantees that each vertex is incident to at most five edges. Further, there are no parallel
edges; that is, if j 6= j
0
, (vj , wj ) 6= (vj
0, wj
0) holds.
Output
First, output n lines. The i-th of these lines should contain two integers xi and yi
, representing the
coordinates where vertex i is embedded. Then, output m lines, where the j-th line represents the polyline
corresponding to edge j, using the following format:
k x0
1
y
0
1
z
0
1
· · · x
0
k
y
0
k
z
0
k
Here, k is the number of nodes, which must be between 2 and 30, inclusive. The points
(x
0
1
, y0
1
, z0
1
), . . . ,(x
0
k
, y0
k
, z0
k
) are the nodes of the polyline. The first point (x
0
1
, y0
1
, z0
1
) must be (xvj
, yvj
, 0),
and the last point (x
0
k
, y0
k
, z0
k
) must be (xwj
, ywj
, 0). Each pair of consecutive points is connected by a
segment to form the polyline. Each segment must have a positive length. Two consecutive segments may
have the same orientation; for example, both can be parallel to the x-axis.
The embedding that you output must satisfy all of the conditions mentioned above.
Under the given input constraints, it can be shown that there exists at least one valid output. If there
are multiple outputs, any one of them will be accepted.

'
WHERE "id" = 2;

INSERT INTO "submissions"("id","participant_id","problem_id", "language", "judgement", "code")
VALUES(4, 12, 2, 'cpp','accepted','#include <bits/stdc++.h>
using namespace std;

#define rep(i, a, b) for(int i = a; i < (b); i++)
#define all(x) begin(x), end(x)
#define sz(x) (int)x.size()


using ll = long long;
using vi = vector<int>;
using vvi = vector<vi>;
using pii = pair<int, int>;
using vii = vector<pii>;
using vl = vector<ll>;

using pt = array<int, 3>;

const int W = 400;
const int K = 32;

void solve() {
    int n, m;
    cin >> n >> m;

    // lock in
    vector<array<int, 2>> ed;
    vector<int> deg(n);
    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;
        u--, v--;
        ed.push_back({u, v});
        deg[u]++;
        deg[v]++;
    }

    vector<pt> starts(n);
    vector<vector<pt>> pts;
    auto get_bid = [&] (array<int, 3> p) {
        return p[0]/(K+4);
    };
    auto get_row = [&] (int rid) {
        return (K+4)*(rid/2) + (rid%2 == 0 ? 1 : K+2);
    };
    {
        int rid = 0;
        int row = get_row(rid);
        int col = 0;
        vector<int> lf(n);
        for (int i = 0; i < n; i++) {
            lf[i] = sz(pts);
            if (deg[i] <= 1) {
                starts[i] = {row, col};
                pts.push_back({{row, col}});
            }
            else if (deg[i] == 2) {
                starts[i] = {row, col+1};
                pts.push_back({{row, col+1}, {row, col}});
                pts.push_back({{row, col+1}});
            }
            else if (deg[i] >= 3) {
                starts[i] = {row, col+2};
                pts.push_back({{row, col+2}, {row-1, col+2}, {row-1, col}, {row, col}});
                pts.push_back({{row, col+2}, {row, col+1}});
                pts.push_back({{row, col+2}});
                if (deg[i] >= 4) {
                    pts.push_back({{row, col+2}, {row, col+3}});
                }
                if (deg[i] >= 5) {
                    pts.push_back({{row, col+2}, {row+1, col+2}, {row+1, col+4}, {row, col+4}});
                }
            }
            col += max(1, deg[i]);
            if (col >= W-(K+6)) {
                col = 0;
                rid++;
                row = get_row(rid);
            }
        }
        for (auto& [u, v] : ed) {
            u = lf[u]++;
            v = lf[v]++;
        }
    }

    vector<vector<pt>> res;

    for (int z = 1; !ed.empty(); z += 3) {
        // vector<int> used_lo(50), used_hi(50);
        auto get_channel = [&] (array<int, 3> p, int c) {
            int bid = get_bid(p);
            return get_row(2*bid) + 1 + c;
        };
        auto go_to_channel = [&] (array<int, 3> p, int c) -> vector<pt> {
            int bid = get_bid(p);
            int channel = get_channel(p, c);
            if (p[0] == get_row(2*bid)) {
                return {{p[0], p[1], z}, {channel, p[1], z}, {channel, p[1], z+1}};
            }
            else {
                return {{p[0], p[1], z+2}, {channel, p[1], z+2}, {channel, p[1], z+1}};
            }
        };
        for (int i = 0; i < K && !ed.empty(); i++) {
            auto [u, v] = ed.back(); ed.pop_back();
            auto a = pts[u].back(), b = pts[v].back();
            a[2] = z;
            b[2] = z;
            if (get_bid(a) == get_bid(b)) {
                if (a[1] == b[1]) {
                    vector<pt> tmp = pts[u];
                    tmp.push_back(a);
                    tmp.push_back(b);
                    tmp.insert(tmp.end(), pts[v].rbegin(), pts[v].rend());
                    res.push_back(tmp);
                }
                else {
                    int channel = get_channel(a, i);
                    vector<pt> tmp = pts[u];
                    auto atoc = go_to_channel(a, i);
                    auto btoc = go_to_channel(b, i);
                    tmp.insert(tmp.end(), atoc.begin(), atoc.end());
                    tmp.insert(tmp.end(), btoc.rbegin(), btoc.rend());
                    tmp.insert(tmp.end(), pts[v].rbegin(), pts[v].rend());
                    res.push_back(tmp);
                }
            }
            else {
                int channel_a = get_channel(a, i);
                int channel_b = get_channel(b, i);
                auto atoc = go_to_channel(a, i);
                auto btoc = go_to_channel(b, i);
                vector<pt> tmp = pts[u];
                tmp.insert(tmp.end(), atoc.begin(), atoc.end());
                tmp.push_back({channel_a, W-(K+1), z+1});
                tmp.push_back({channel_a, W-(K+1), z});
                tmp.push_back({channel_a, W-K + i, z});
                tmp.push_back({channel_a, W-K + i, z+1});

                tmp.push_back({channel_b, W-K + i, z+1});
                tmp.push_back({channel_b, W-K + i, z});
                tmp.push_back({channel_b, W-(K+1), z});
                tmp.push_back({channel_b, W-(K+1), z+1});
                tmp.insert(tmp.end(), btoc.rbegin(), btoc.rend());
                tmp.insert(tmp.end(), pts[v].rbegin(), pts[v].rend());
                res.push_back(tmp);
            }
        }
    }

    ranges::reverse(res);

    for (int i = 0; i < n; i++) {
        cout << starts[i][0] << " " << starts[i][1] << " " << "\n";
    }
    for (int i = 0; i < m; i++) {
        cout << sz(res[i]) << " ";
        for (auto [x, y, z] : res[i]) cout << x << " " <<  y << " " << z << " ";
        cout << "\n";
    }
}

int main() {
    cin.tie(0)->sync_with_stdio(0);
    cin.exceptions(cin.failbit);

    solve();

    return 0;
}');

UPDATE "participants_competitions"
SET "score" = 550, "rank" = 1
WHERE "participant_id" = 12;
UPDATE "participants_competitions"
SET "score" = 450, "rank" = 2
WHERE "participant_id" = 11;
UPDATE "participants_competitions"
SET "score" = 300, "rank" = 3
WHERE "participant_id" = 13;
UPDATE "participants_competitions"
SET "score" = 200, "rank" = 4
WHERE "participant_id" = 14;
UPDATE "participants_competitions"
SET "score" = 100, "rank" = 5
WHERE "participant_id" = 15;




--Showing users
SELECT * FROM "users"
ORDER BY "name";

--Showing team
SELECT * FROM  "participants"
ORDER BY "name";

--Showing user's teams
SELECT * FROM "teams_names";

--showing competitions and their creator
SELECT * FROM "competitions_view"
WHERE "name" LIKE 'Hackathon challenge';

--Showing the results of the competition named Hackathon challenge
SELECT * FROM "scoreboard"
WHERE "competition" LIKE 'Hackathon challenge';

--Showing each participant name with the code submitted for each problem with its judgement
SELECT * from "participants_submissions";

--showing the number of accepted submissions for each problem
SELECT * from "problems_view";

UPDATE competitions
SET starting_time = '2025-04-10 14:00:00'
WHERE name = 'Spring Challenge';

UPDATE participants_competitions
SET score = score + 10
WHERE participant_id = (SELECT id FROM participants WHERE name = 'TeamABC')
AND competition_id = (SELECT id FROM competitions WHERE name = 'Winter Code Fest');

DELETE FROM test_cases WHERE problem_id = (SELECT id FROM problems WHERE label='B');



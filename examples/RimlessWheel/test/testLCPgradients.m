function testLCPgradients

options.floating = true;
m = PlanarRigidBodyManipulator('../RimlessWheel.urdf',options);

p = TimeSteppingRigidBodyManipulator(m,.01);
x0 = double(p.resolveConstraints([0;0;randn;5*rand;randn;5*rand]));
v = p.constructVisualizer();
v.draw(0,x0);

%% as a debugging step (e.g.,when update doesn't actually call LCP, but returns M,dM)
%options.grad_method = {'user','taylorvar'};
%[f,df] = geval(@update,p,0,x0,[],options);
%return;


% first just ask for the gradients (todo: add a specific check)
[xdn,df] = update(p,0,x0,[]);

options.input_name={'t','q1','q2','q3','qd1','qd2','qd3'};
options.output_name={'qn1','qn2','qn3','qdn1','qdn2','qdn3'};
options.output=false;
options.scale = .001;
gradTest(p,0,x0,[],options);


end

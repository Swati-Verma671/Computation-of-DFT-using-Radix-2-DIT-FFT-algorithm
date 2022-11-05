function a=DSPdemo(x)
p=nextpow2(length(x)); %determining the length closest to the power of 2
x=[x zeros(1,((2^p)-length(x)))]; %padding with zeros if necessary
N=length(x); %Length of the input array
S=log2(N); %determining the no. of stages
x=bitrevorder(x); %reversing the bit order of the input sequence
for stage=1:S %iterating through each stage
    p=1; %initialising the butterfly sequence
    q=1+2^(stage-1);
    n=0;
    while(n<=(2^(stage-1)-1) && q<=N)
        w=exp((-1i)*2*pi*n/(2^stage)); %Incorporating the twiddle factor
        y=x(p)+w*x(q); %Equation for 1st part of butterfly operation
        z=x(p)-w*x(q); %Equation for 2nd part of butterfly operation
        x(p)=y; %Equating
        x(q)=z;
        p=p+1; % Incrementing the sequences for next butterfly structure
        q=q+1;
        n=n+1;
        if(rem(q,2^stage)==1) % repetition of the butterfly
            p=p+2^(stage-1);% structure for other input sequences
            q=q+2^(stage-1);
            n=0;
        end
    end
end
a=x;
end

%   CSP Function

%   Coded by James Ethridge and William Weaver
function [result] = CSP(varargin)
    

    if (nargin ~= 2)
        disp('Must have 2 classes for CSP!')
    end
    
    %finding the covariance of each class and composite covariance
    R1 = ((varargin{1}*varargin{1}')/trace(varargin{1}*varargin{1}'));
    R2 = ((varargin{2}*varargin{2}')/trace(varargin{2}*varargin{2}'));
    Rsum = R1+R2;

    %   Find Eigenvalues and Eigenvectors of RC
    %   Sort eigenvalues in descending order
    [EVecsum,EValsum] = eig(Rsum);
    [EValsum,ind] = sort(diag(EValsum),'descend');
    EVecsum = EVecsum(:,ind);
    
    %   Find Whitening Transformation Matrix - Ramoser Equation (3)
    W = sqrt(inv(diag(EValsum))) * EVecsum';
    
    S1 = W * R1 * W';
    S2 = W * R2 * W';

    %generalized eigenvectors/values
    [B,D] = eig(S1,S2);
    % Simultanous diagonalization
			% Should be equivalent to [B,D]=eig(S1);
    
    %sort ascending by default
    [~,ind]=sort(diag(D));B=B(:,ind);
    
    %Resulting Projection Matrix-these are the spatial filter coefficients
    result = B'*W;
end

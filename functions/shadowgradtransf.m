function[grad_new] = shadowgradtransf(grad, mus, sigmas, mut, sigmat)

grad_new = (grad-mus)*sigmat;
grad_new = grad_new/sigmas;
grad_new = mut + grad_new;
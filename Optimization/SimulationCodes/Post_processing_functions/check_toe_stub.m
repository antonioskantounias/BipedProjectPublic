function [stub] = check_toe_stub(footshape,L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,yH)
    
    yc2=c2y_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,yH);
    x_el=footshape.x;
    y_el=footshape.y;
    psiT = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK);
%     whos x_el
%     whos y_el
%     whos psiB
    [el_rot2x,el_rot2y]=rotate_coord(x_el,y_el,psiT);
    yel_2=el_rot2y+yc2;
    stub=0;
    if min(min(yel_2))<-10^-5
        stub=1;
    end
end

